import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tmdb/core/entities/error/custom_error_entity.dart';
import 'package:tmdb/core/error/custom_error_utl.dart';
import 'package:tmdb/core/ui/initialize_app.dart';
import 'package:tmdb/features/ads_manager/presentation/blocs/ads_manager_bloc.dart';
import 'package:tmdb/features/main/movies/sub_features/details/domain/entities/movie_details_entity.dart';
import 'package:tmdb/features/main/movies/sub_features/details/domain/use_cases/movie_details_use_case.dart';

part 'movie_details_event.dart';
part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final AdsManagerBloc _adsManagerBloc;
  final MovieDetailsUseCase _useCase;

  MovieDetailsBloc(this._adsManagerBloc, this._useCase)
    : super(MovieDetailsStateInitial()) {
    on<MovieDetailsEventLoad>((event, emit) async {
      await _onLoad(event, emit);
    });
  }

  Future<void> _onLoad(
    MovieDetailsEventLoad event,
    Emitter<MovieDetailsState> emit,
  ) async {
    emit(MovieDetailsStateLoading());
    try {
      final movieDetails = await _useCase.call(event.movieId);
      AdsManagerBloc.increment(_adsManagerBloc);
      emit(MovieDetailsStateLoaded(movieDetails));
    } catch (e) {
      logger.e(e);
      final error = CustomErrorUtl.getError(e);
      AdsManagerBloc.incrementOnError(_adsManagerBloc, error);
      emit(MovieDetailsStateError(error));
    }
  }
}
