import 'package:flutter/material.dart';
import 'package:tmdb/models/details/collection_details_data.dart';

class CollectionDetailsState {
  const CollectionDetailsState();
}

class CollectionDetailsLoading extends CollectionDetailsState {}

class CollectionDetailsLoaded extends CollectionDetailsState {
  final CollectionDetailsData collectionDetailsData;

  const CollectionDetailsLoaded({@required this.collectionDetailsData});
}

class CollectionDetailsLoadingError extends CollectionDetailsState {
  final dynamic error;

  const CollectionDetailsLoadingError({@required this.error});
}
