import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class UserSessionEntity extends Equatable {
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(name: 'username')
  final String username;
  @JsonKey(name: 'session_id')
  final String sessionId;

  UserSessionEntity({
    required this.userId,
    required this.username,
    required this.sessionId,
  });

  factory UserSessionEntity.empty() =>
      UserSessionEntity(userId: 0, username: '', sessionId: '');

  bool get isEmpty => (userId == 0) && (username.isEmpty || sessionId.isEmpty);

  @override
  List<Object?> get props => [userId, username, sessionId];
}
