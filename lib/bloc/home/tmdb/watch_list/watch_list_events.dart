import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/models/user_info_model.dart';

class WatchListEvent extends Equatable {
  const WatchListEvent();

  @override
  List<Object> get props => [];
}

class LoadWatchList extends WatchListEvent {
  final UserInfoModel user;

  const LoadWatchList({@required this.user});

  @override
  List<Object> get props => [user];
}
