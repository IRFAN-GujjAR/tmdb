part of 'movie_collection_details_bloc.dart';

sealed class MovieCollectionDetailsState extends Equatable {
  const MovieCollectionDetailsState();

  @override
  List<Object> get props => [];
}

final class MovieCollectionDetailsStateInitial
    extends MovieCollectionDetailsState {}

final class MovieCollectionDetailsStateLoading
    extends MovieCollectionDetailsState {}

final class MovieCollectionDetailsStateLoaded
    extends MovieCollectionDetailsState {
  final MovieCollectionDetailsEntity movieCollectionDetails;

  MovieCollectionDetailsStateLoaded(this.movieCollectionDetails);

  @override
  List<Object> get props => [movieCollectionDetails];
}

final class MovieCollectionDetailsStateError
    extends MovieCollectionDetailsState {
  final CustomErrorEntity error;

  MovieCollectionDetailsStateError(this.error);

  @override
  List<Object> get props => [error];
}
