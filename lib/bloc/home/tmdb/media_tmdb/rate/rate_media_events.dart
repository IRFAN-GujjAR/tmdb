import 'package:flutter/material.dart';
import 'package:tmdb/models/user_info_model.dart';

class RateMediaEvent {
  final UserInfoModel user;
  final int mediaId;

  const RateMediaEvent(this.user, this.mediaId);
}

class AddRatingRateMedia extends RateMediaEvent {
  final int rating;

  AddRatingRateMedia(
      {@required UserInfoModel user,
      @required int mediaId,
      @required this.rating})
      : super(user, mediaId);
}

class DeleteRatingRateMedia extends RateMediaEvent {
  DeleteRatingRateMedia({@required UserInfoModel user, @required int mediaId})
      : super(user, mediaId);
}
