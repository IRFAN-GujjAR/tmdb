import 'package:equatable/equatable.dart';

final class LoginParams extends Equatable {
  final String username;
  final String password;

  LoginParams(this.username, this.password);

  @override
  List<Object?> get props => [username, password];
}
