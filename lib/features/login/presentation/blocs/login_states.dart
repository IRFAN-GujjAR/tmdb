part of 'login_bloc.dart';

sealed class LoginState extends Equatable {}

final class LoginStateEmpty extends LoginState {
  @override
  List<Object?> get props => [];
}

final class LoginStateLoggingIn extends LoginState {
  @override
  List<Object?> get props => [];
}

final class LoginStateLoggedIn extends LoginState {
  final UserSessionEntity userSession;

  LoginStateLoggedIn(this.userSession);

  @override
  List<Object?> get props => [];
}

final class LoginStateError extends LoginState {
  final CustomErrorEntity error;

  LoginStateError(this.error);

  @override
  List<Object?> get props => [error];
}
