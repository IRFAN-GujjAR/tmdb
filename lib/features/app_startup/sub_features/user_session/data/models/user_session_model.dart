import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/features/app_startup/sub_features/user_session/domain/entities/user_session_entity.dart';

part 'user_session_model.g.dart';

@JsonSerializable(createToJson: false, ignoreUnannotated: true)
final class UserSessionModel extends UserSessionEntity {
  UserSessionModel({required super.sessionId, required super.userId});

  factory UserSessionModel.empty() =>
      UserSessionModel(userId: 0, sessionId: '');

  factory UserSessionModel.fromJson(Map<String, dynamic> json) =>
      _$UserSessionModelFromJson(json);
}
