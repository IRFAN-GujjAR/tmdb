import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class UserSessionEntity extends Equatable {
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(name: 'session_id')
  final String sessionId;

  UserSessionEntity({required this.userId, required this.sessionId});

  factory UserSessionEntity.empty() =>
      UserSessionEntity(userId: 0, sessionId: '');

  bool get isEmpty => userId == 0 && sessionId.isEmpty;

  @override
  List<Object?> get props => [userId, sessionId];
}
