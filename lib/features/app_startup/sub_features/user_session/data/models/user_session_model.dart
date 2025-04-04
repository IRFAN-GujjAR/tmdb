import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/user_session_entity.dart';

part 'user_session_model.g.dart';

@JsonSerializable(createToJson: false, ignoreUnannotated: true)
final class UserSessionModel extends UserSessionEntity {
  UserSessionModel({
    required super.userId,
    required super.username,
    required super.sessionId,
  });

  factory UserSessionModel.empty() =>
      UserSessionModel(userId: 0, username: '', sessionId: '');

  factory UserSessionModel.fromJson(Map<String, dynamic> json) =>
      _$UserSessionModelFromJson(json);
}
