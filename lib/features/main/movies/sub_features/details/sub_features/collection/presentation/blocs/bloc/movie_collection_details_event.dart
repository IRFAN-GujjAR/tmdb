part of 'movie_collection_details_bloc.dart';

sealed class MovieCollectionDetailsEvent extends Equatable {
  const MovieCollectionDetailsEvent();

  @override
  List<Object> get props => [];
}

final class MovieCollectionDetailsEventLoad
    extends MovieCollectionDetailsEvent {
  final int collectionId;

  const MovieCollectionDetailsEventLoad(this.collectionId);

  @override
  List<Object> get props => [collectionId];
}
