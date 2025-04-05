import 'package:equatable/equatable.dart';

final class AccountDetailsEntity extends Equatable {
  final String username;
  final String? profilePath;

  const AccountDetailsEntity({
    required this.username,
    required this.profilePath,
  });

  @override
  List<Object?> get props => [username, profilePath];
}
