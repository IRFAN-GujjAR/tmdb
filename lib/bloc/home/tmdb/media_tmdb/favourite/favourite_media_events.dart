import 'package:flutter/material.dart';
import 'package:tmdb/models/user_info_model.dart';

class FavouriteMediaEvent {
  final UserInfoModel user;
  final int mediaId;

  const FavouriteMediaEvent(this.user, this.mediaId);
}

class MarkFavouriteMedia extends FavouriteMediaEvent {
  final bool mark = true;

  MarkFavouriteMedia({@required UserInfoModel user, @required int mediaId})
      : super(user, mediaId);
}

class UnMarkFavouriteMedia extends FavouriteMediaEvent {
  final bool mark = false;

  UnMarkFavouriteMedia({@required UserInfoModel user, @required int mediaId})
      : super(user, mediaId);
}
