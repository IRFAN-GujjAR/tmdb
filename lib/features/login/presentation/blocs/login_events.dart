part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

final class LoginEventUser extends LoginEvent {
  final String userName, password;

  const LoginEventUser({required this.userName, required this.password});

  @override
  List<Object> get props => [userName, password];
}
