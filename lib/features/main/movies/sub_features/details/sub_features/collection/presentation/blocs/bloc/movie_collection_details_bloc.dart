import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tmdb/core/entities/error/custom_error_entity.dart';
import 'package:tmdb/core/error/custom_error_utl.dart';
import 'package:tmdb/core/ui/initialize_app.dart';
import 'package:tmdb/features/ads_manager/presentation/blocs/ads_manager_bloc.dart';
import 'package:tmdb/features/main/movies/sub_features/details/sub_features/collection/domain/entities/movie_collection_details_entity.dart';
import 'package:tmdb/features/main/movies/sub_features/details/sub_features/collection/domain/use_cases/movie_collection_details_use_case.dart';

part 'movie_collection_details_event.dart';
part 'movie_collection_details_state.dart';

class MovieCollectionDetailsBloc
    extends Bloc<MovieCollectionDetailsEvent, MovieCollectionDetailsState> {
  final AdsManagerBloc _adsManagerBloc;
  final MovieCollectionDetailsUseCase _useCase;
  MovieCollectionDetailsBloc(this._adsManagerBloc, this._useCase)
    : super(MovieCollectionDetailsStateInitial()) {
    on<MovieCollectionDetailsEvent>((event, emit) async {
      switch (event) {
        case MovieCollectionDetailsEventLoad():
          await _onLoad(event, emit);
          break;
      }
    });
  }

  Future<void> _onLoad(
    MovieCollectionDetailsEventLoad event,
    Emitter<MovieCollectionDetailsState> emit,
  ) async {
    emit(MovieCollectionDetailsStateLoading());
    try {
      final movieCollectionDetails = await _useCase.call(event.collectionId);
      AdsManagerBloc.increment(_adsManagerBloc);
      emit(MovieCollectionDetailsStateLoaded(movieCollectionDetails));
    } catch (e) {
      logger.e(e);
      final error = CustomErrorUtl.getError(e);
      AdsManagerBloc.incrementOnError(_adsManagerBloc, error);
      emit(MovieCollectionDetailsStateError(error));
    }
  }
}
