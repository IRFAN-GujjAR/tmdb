import 'package:flutter/material.dart';

class UserInfoModel {
  final int userId;
  final String userName;
  final String sessionId;

  const UserInfoModel(
      {@required this.userId,
      @required this.userName,
      @required this.sessionId});
}
