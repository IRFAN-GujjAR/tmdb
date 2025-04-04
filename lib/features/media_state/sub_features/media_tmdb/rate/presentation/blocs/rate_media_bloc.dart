import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/core/error/custom_error_utl.dart';
import 'package:tmdb/core/ui/initialize_app.dart';
import 'package:tmdb/features/ads_manager/presentation/blocs/ads_manager_bloc.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/rate/domain/entities/rate_media_result_entity.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/rate/domain/repositories/rate_media_repo.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/rate/domain/use_cases/params/rate_media_delete_rating_params.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/rate/domain/use_cases/params/rate_media_rate_params.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/rate/domain/use_cases/rate_media_use_case_delete_movie_rating.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/rate/domain/use_cases/rate_media_use_case_delete_tv_show_rating.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/rate/domain/use_cases/rate_media_use_case_rate_movie.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/rate/domain/use_cases/rate_media_use_case_rate_tv_show.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/rate/presentation/blocs/rate_media_event.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/rate/presentation/blocs/rate_media_state.dart';

final class RateMediaBloc extends Bloc<RateMediaEvent, RateMediaState> {
  final AdsManagerBloc _adsManagerBloc;
  late RateMediaUseCaseRateMovie _useCaseRateMovie;
  late RateMediaUseCaseRateTvShow _useCaseRateTvShow;
  late RateMediaUseCaseDeleteMovieRating _useCaseDeleteMovieRating;
  late RateMediaUseCaseDeleteTvShowRating _useCaseDeleteTvShowRating;

  RateMediaBloc(this._adsManagerBloc, {required RateMediaRepo rateMediaRepo})
    : super(RateMediaStateInitial()) {
    _useCaseRateMovie = RateMediaUseCaseRateMovie(rateMediaRepo);
    _useCaseRateTvShow = RateMediaUseCaseRateTvShow(rateMediaRepo);
    _useCaseDeleteMovieRating = RateMediaUseCaseDeleteMovieRating(
      rateMediaRepo,
    );
    _useCaseDeleteTvShowRating = RateMediaUseCaseDeleteTvShowRating(
      rateMediaRepo,
    );
    on<RateMediaEvent>((event, emit) async {
      switch (event) {
        case RateMediaEventRateMovie():
          await _onRate(event.params, emit, isMovie: true);
          break;
        case RateMediaEventRateTvShow():
          await _onRate(event.params, emit, isMovie: false);
          break;
        case RateMediaEventDeleteMovieRating():
          await _onDeleteRating(event.params, emit, isMovie: true);
          break;
        case RateMediaEventDeleteTvShowRating():
          await _onDeleteRating(event.params, emit, isMovie: false);
          break;
      }
    });
  }

  Future<void> _onRate(
    RateMediaRateParams params,
    Emitter<RateMediaState> emit, {
    required bool isMovie,
  }) async {
    emit(RateMediaStateRating());
    try {
      late RateMediaResultEntity result;
      if (isMovie) {
        result = await _useCaseRateMovie.call(params);
      } else {
        result = await _useCaseRateTvShow.call(params);
      }
      AdsManagerBloc.increment(_adsManagerBloc);
      switch (result.statusCode) {
        case 1:
        case 12:
        case 13:
          emit(RateMediaStateRated());
          break;
        default:
          emit(RateMediaStateError(errorMsg: result.statusMessage!));
          break;
      }
    } catch (e) {
      logger.e(e);
      final error = CustomErrorUtl.getError(e);
      AdsManagerBloc.incrementOnError(_adsManagerBloc, error);
      emit(RateMediaStateError(errorMsg: error.error.errorMessage));
    }
  }

  Future<void> _onDeleteRating(
    RateMediaDeleteRatingParams params,
    Emitter<RateMediaState> emit, {
    required bool isMovie,
  }) async {
    emit(RateMediaStateDeletingRating());
    try {
      late RateMediaResultEntity result;
      if (isMovie) {
        result = await _useCaseDeleteMovieRating.call(params);
      } else {
        result = await _useCaseDeleteTvShowRating.call(params);
      }
      AdsManagerBloc.increment(_adsManagerBloc);
      switch (result.statusCode) {
        case 1:
        case 12:
        case 13:
          emit(RateMediaStateDeletedRating());
          break;
        default:
          emit(RateMediaStateError(errorMsg: result.statusMessage!));
          break;
      }
    } catch (e) {
      logger.d(e);
      final error = CustomErrorUtl.getError(e);
      AdsManagerBloc.incrementOnError(_adsManagerBloc, error);
      emit(RateMediaStateError(errorMsg: error.error.errorMessage));
    }
  }
}
