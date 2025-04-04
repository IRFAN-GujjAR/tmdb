import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tmdb/core/database/app_database.dart';
import 'package:tmdb/core/entities/celebs/celebrity_entity.dart';
import 'package:tmdb/core/entities/error/custom_error_entity.dart';
import 'package:tmdb/core/error/custom_error_utl.dart';
import 'package:tmdb/core/ui/initialize_app.dart';
import 'package:tmdb/features/ads_manager/presentation/blocs/ads_manager_bloc.dart';
import 'package:tmdb/features/main/celebrities/domain/entities/celebrities_entity.dart';
import 'package:tmdb/features/main/celebrities/domain/use_cases/celebrities_use_case_load.dart';
import 'package:tmdb/features/main/celebrities/domain/use_cases/celebrities_use_case_watch.dart';

import '../../../../../core/entities/celebs/celebrities_list_entity.dart';

part 'celebrities_event.dart';
part 'celebrities_state.dart';

class CelebritiesBloc extends Bloc<CelebritiesEvent, CelebritiesState> {
  final AdsManagerBloc _adsManagerBloc;
  final CelebritiesUseCaseWatch _watchUseCase;
  final CelebritiesUseCaseLoad _loadUseCase;
  late StreamSubscription _subscription;

  CelebritiesBloc(this._adsManagerBloc, this._watchUseCase, this._loadUseCase)
    : super(CelebritiesStateLoading()) {
    _subscription = _watchUseCase.call.listen((value) {
      if (value != null) {
        _onWatch(value);
      }
    });

    on<CelebritiesEvent>((event, emit) async {
      switch (event) {
        case CelebritiesEventLoad():
          _onLoad(emit);
        case CelebritiesEventUpdated():
          _onUpdated(event, emit);
          break;
        case CelebritiesEventRefresh():
          _onLoad(emit, completer: event.completer);
          break;
      }
    });
  }

  void _onWatch(CelebsTableData value) {
    final celebsPopularModel = value.popular;
    final celebsPopularEntity = CelebritiesListEntity(
      pageNo: celebsPopularModel.pageNo,
      totalPages: celebsPopularModel.totalPages,
      celebrities: celebsPopularModel.celebrities,
    );

    final celebsTrendingModel = value.trending;
    final celebsTrendingEntity = CelebritiesListEntity(
      pageNo: celebsTrendingModel.pageNo,
      totalPages: celebsTrendingModel.totalPages,
      celebrities: celebsTrendingModel.celebrities,
    );

    add(
      CelebritiesEventUpdated(
        celebs: CelebritiesEntity(
          popular: celebsPopularEntity,
          trending: celebsTrendingEntity,
        ),
      ),
    );
  }

  Future<void> _onLoad(
    Emitter<CelebritiesState> emit, {
    Completer<void>? completer,
  }) async {
    if (state is CelebritiesStateErrorWithoutCache)
      emit(CelebritiesStateLoading());
    try {
      await _loadUseCase.call;
      AdsManagerBloc.increment(_adsManagerBloc);
      completer?.complete();
    } catch (e) {
      logger.e(e);
      completer?.complete();
      final errorEntity = CustomErrorUtl.getError(e);
      AdsManagerBloc.incrementOnError(_adsManagerBloc, errorEntity);
      if (state is CelebritiesStateLoaded) {
        final data = state as CelebritiesStateLoaded;
        emit(
          CelebritiesStateErrorWithCache(
            celebrities: data.celebrities,
            firstHalfPopular: data.firstHalfPopular,
            secondHalfPopular: data.secondHalfPopular,
            error: errorEntity,
          ),
        );
      } else
        emit(CelebritiesStateErrorWithoutCache(error: errorEntity));
    }
  }

  void _onUpdated(
    CelebritiesEventUpdated event,
    Emitter<CelebritiesState> emit,
  ) {
    final popularCelebs = event.celebs.popular.celebrities;
    final firstHalfPopular = <CelebrityEntity>[];
    final secondHalfPopular = <CelebrityEntity>[];
    int firstHalfLength = (popularCelebs.length / 2).round();
    for (int i = 0; i < popularCelebs.length; i++) {
      if (i < firstHalfLength) {
        firstHalfPopular.add(popularCelebs[i]);
      } else {
        secondHalfPopular.add(popularCelebs[i]);
      }
    }
    emit(
      CelebritiesStateLoaded(
        celebrities: event.celebs,
        firstHalfPopular: firstHalfPopular,
        secondHalfPopular: secondHalfPopular,
      ),
    );
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
