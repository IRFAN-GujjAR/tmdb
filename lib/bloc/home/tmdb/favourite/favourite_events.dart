import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/models/user_info_model.dart';

class FavouriteEvent extends Equatable {
  const FavouriteEvent();

  @override
  List<Object> get props => [];
}

class LoadFavourite extends FavouriteEvent {
  final UserInfoModel user;

  const LoadFavourite({@required this.user});

  @override
  List<Object> get props => [user];
}
