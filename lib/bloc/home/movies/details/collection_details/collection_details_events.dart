import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CollectionDetailsEvent extends Equatable {
  const CollectionDetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadCollectionDetails extends CollectionDetailsEvent {
  final int id;

  const LoadCollectionDetails({@required this.id});

  @override
  List<Object> get props => [id];
}
