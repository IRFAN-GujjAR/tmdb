import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/models/user_info_model.dart';

class RatedEvent extends Equatable {
  const RatedEvent();

  @override
  List<Object> get props => [];
}

class LoadRated extends RatedEvent {
  final UserInfoModel user;

  const LoadRated({@required this.user});

  @override
  List<Object> get props => [user];
}
