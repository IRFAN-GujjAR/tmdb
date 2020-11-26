import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CelebrityDetailsEvent extends Equatable {
  const CelebrityDetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadCelebrityDetails extends CelebrityDetailsEvent {
  final int id;

  const LoadCelebrityDetails({@required this.id});

  @override
  List<Object> get props => [id];
}
