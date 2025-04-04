import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tmdb/core/database/app_database.dart';
import 'package:tmdb/core/entities/error/custom_error_entity.dart';
import 'package:tmdb/core/error/custom_error_utl.dart';
import 'package:tmdb/features/ads_manager/presentation/blocs/ads_manager_bloc.dart';
import 'package:tmdb/features/main/tv_shows/domain/entities/tv_shows_entity.dart';
import 'package:tmdb/features/main/tv_shows/domain/use_cases/tv_shows_use_case_load.dart';
import 'package:tmdb/features/main/tv_shows/domain/use_cases/tv_shows_use_case_watch.dart';

import '../../../../../core/ui/initialize_app.dart';

part 'tv_shows_event.dart';
part 'tv_shows_state.dart';

class TvShowsBloc extends Bloc<TvShowsEvent, TvShowsState> {
  final AdsManagerBloc _adsManagerBloc;
  final TvShowsUseCaseWatch _useCaseWatch;
  final TvShowsUseCaseLoad _useCaseLoad;
  late StreamSubscription _subscription;

  TvShowsBloc(this._adsManagerBloc, this._useCaseWatch, this._useCaseLoad)
    : super(TvShowsStateLoading()) {
    _subscription = _useCaseWatch.call.listen((value) {
      if (value != null) _onWatch(value);
    });
    on<TvShowsEvent>((event, emit) async {
      switch (event) {
        case TvShowsEventLoad():
          await _onLoad(emit);
          break;
        case TvShowsEventUpdated():
          emit(TvShowsStateLoaded(event.tvShows));
          break;
        case TvShowsEventRefresh():
          await _onLoad(emit, completer: event.completer);
          break;
      }
    });
  }

  void _onWatch(TvShowsTableData value) {
    add(
      TvShowsEventUpdated(
        TvShowsEntity(
          airingToday: value.airingToday.toEntity,
          trending: value.trending.toEntity,
          topRated: value.topRated.toEntity,
          popular: value.popular.toEntity,
        ),
      ),
    );
  }

  Future<void> _onLoad(
    Emitter<TvShowsState> emit, {
    Completer<void>? completer,
  }) async {
    if (state is TvShowsStateErrorWithoutCache) emit(TvShowsStateLoading());
    try {
      await _useCaseLoad.call;
      AdsManagerBloc.increment(_adsManagerBloc);
      if (completer != null) completer.complete();
    } catch (e) {
      logger.e(e);
      if (completer != null) {
        completer.complete();
      }
      final errorEntity = CustomErrorUtl.getError(e);
      AdsManagerBloc.incrementOnError(_adsManagerBloc, errorEntity);
      if (state is TvShowsStateLoaded) {
        final data = state as TvShowsStateLoaded;
        emit(
          TvShowsStateErrorWithCache(tvShows: data.tvShows, error: errorEntity),
        );
      } else
        emit(TvShowsStateErrorWithoutCache(errorEntity));
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
