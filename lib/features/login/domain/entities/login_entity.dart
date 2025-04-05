import 'package:equatable/equatable.dart';

final class LoginEntity extends Equatable {
  final String sessionId;
  final int userId;
  final String username;
  final String? profilePath;

  const LoginEntity({
    required this.sessionId,
    required this.userId,
    required this.username,
    required this.profilePath,
  });

  @override
  List<Object?> get props => [sessionId, userId, username, profilePath];
}
