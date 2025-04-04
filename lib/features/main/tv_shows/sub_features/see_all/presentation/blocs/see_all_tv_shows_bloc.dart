import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tmdb/core/entities/error/custom_error_entity.dart';
import 'package:tmdb/core/ui/initialize_app.dart';
import 'package:tmdb/features/ads_manager/presentation/blocs/ads_manager_bloc.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/see_all/domain/use_cases/params/see_all_tv_shows_params.dart';

import '../../../../../../../core/entities/tv_show/tv_shows_list_entity.dart';
import '../../../../../../../core/error/custom_error_utl.dart';
import '../../domain/use_cases/see_all_tv_shows_use_case.dart';

part 'see_all_tv_shows_event.dart';
part 'see_all_tv_shows_state.dart';

class SeeAllTvShowsBloc extends Bloc<SeeAllTvShowsEvent, SeeAllTvShowsState> {
  final AdsManagerBloc _adsManagerBloc;
  final SeeAllTvShowsUseCase _useCase;

  SeeAllTvShowsBloc(this._adsManagerBloc, this._useCase)
    : super(SeeAllTvShowsStateInitial()) {
    on<SeeAllTvShowsEvent>((event, emit) async {
      switch (event) {
        case SeeAllTvShowsEventLoad():
          await _onLoad(event, emit);
          break;
      }
    });
  }

  Future<void> _onLoad(
    SeeAllTvShowsEventLoad event,
    Emitter<SeeAllTvShowsState> emit,
  ) async {
    emit(SeeAllTvShowsStateLoading());
    try {
      final tvShowsList = await _useCase.call(event.params);
      AdsManagerBloc.increment(_adsManagerBloc);
      emit(SeeAllTvShowsStateLoaded(tvShowsList));
    } catch (e) {
      logger.e(e);
      final error = CustomErrorUtl.getError(e);
      AdsManagerBloc.incrementOnError(_adsManagerBloc, error);
      emit(SeeAllTvShowsStateError(error));
    }
  }
}
