import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/bloc/home/movies/details/collection_details/collection_details_events.dart';
import 'package:tmdb/bloc/home/movies/details/collection_details/collection_details_states.dart';
import 'package:tmdb/repositories/home/movies/movie_details/collection_details/collection_details_repo.dart';

class CollectionDetailsBloc
    extends Bloc<CollectionDetailsEvent, CollectionDetailsState> {
  CollectionDetailsRepo _collectionDetailsRepo;

  CollectionDetailsBloc({@required CollectionDetailsRepo collectionDetailsRepo})
      : _collectionDetailsRepo = collectionDetailsRepo,
        super(CollectionDetailsState());

  @override
  Stream<CollectionDetailsState> mapEventToState(
      CollectionDetailsEvent event) async* {
    if (event is LoadCollectionDetails) {
      yield* _loadCollectionDetails(event);
    }
  }

  Stream<CollectionDetailsState> _loadCollectionDetails(
      LoadCollectionDetails event) async* {
    yield CollectionDetailsLoading();
    try {
      final collectionDetails =
          await _collectionDetailsRepo.loadCollectionDetails(event.id, 1);
      yield CollectionDetailsLoaded(collectionDetailsData: collectionDetails);
    } catch (error) {
      yield CollectionDetailsLoadingError(error: error);
    }
  }
}
