import 'package:flutter/material.dart';
import 'package:tmdb/models/user_info_model.dart';

class WatchListMediaEvent {
  final UserInfoModel user;
  final int mediaId;

  const WatchListMediaEvent(this.user, this.mediaId);
}

class AddWatchListMedia extends WatchListMediaEvent {
  final bool add = true;

  AddWatchListMedia({@required UserInfoModel user, @required int mediaId})
      : super(user, mediaId);
}

class RemoveWatchListMedia extends WatchListMediaEvent {
  final bool add = false;

  RemoveWatchListMedia({@required UserInfoModel user, @required int mediaId})
      : super(user, mediaId);
}
