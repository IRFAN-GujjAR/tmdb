import 'package:flutter/material.dart';

class FavouriteMediaState {
  const FavouriteMediaState();
}

class FavouriteMediaLoading extends FavouriteMediaState {}

class FavouriteMediaMarked extends FavouriteMediaState {
  final int mediaId;

  const FavouriteMediaMarked({@required this.mediaId});
}

class FavouriteMediaUnMarked extends FavouriteMediaState {
  final int mediaId;

  const FavouriteMediaUnMarked({@required this.mediaId});
}

class FavouriteMediaError extends FavouriteMediaState {
  final dynamic error;

  const FavouriteMediaError({@required this.error});
}
