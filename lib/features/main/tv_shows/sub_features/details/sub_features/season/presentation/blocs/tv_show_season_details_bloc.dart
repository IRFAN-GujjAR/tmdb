import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tmdb/core/entities/error/custom_error_entity.dart';
import 'package:tmdb/core/error/custom_error_utl.dart';
import 'package:tmdb/core/ui/initialize_app.dart';
import 'package:tmdb/features/ads_manager/presentation/blocs/ads_manager_bloc.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/details/sub_features/season/domain/entities/tv_show_season_details_entity.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/details/sub_features/season/domain/use_cases/params/tv_show_season_details_params.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/details/sub_features/season/domain/use_cases/tv_show_season_details_use_case.dart';

part 'tv_show_season_details_event.dart';
part 'tv_show_season_details_state.dart';

class TvShowSeasonDetailsBloc
    extends Bloc<TvShowSeasonDetailsEvent, TvShowSeasonDetailsState> {
  final AdsManagerBloc _adsManagerBloc;
  final TvShowSeasonDetailsUseCase _useCase;

  TvShowSeasonDetailsBloc(this._adsManagerBloc, this._useCase)
    : super(TvShowSeasonDetailsStateInitial()) {
    on<TvShowSeasonDetailsEvent>((event, emit) async {
      switch (event) {
        case TvShowSeasonDetailsEventLoad():
          await _onLoad(event, emit);
          break;
      }
    });
  }

  Future<void> _onLoad(
    TvShowSeasonDetailsEventLoad event,
    Emitter<TvShowSeasonDetailsState> emit,
  ) async {
    emit(TvShowSeasonDetailsStateLoading());
    try {
      final seasonDetails = await _useCase.call(event.params);
      AdsManagerBloc.increment(_adsManagerBloc);
      emit(TvShowSeasonDetailsStateLoaded(seasonDetails));
    } catch (e) {
      logger.e(e);
      final error = CustomErrorUtl.getError(e);
      AdsManagerBloc.incrementOnError(_adsManagerBloc, error);
      emit(TvShowSeasonDetailsStateError(error));
    }
  }
}
