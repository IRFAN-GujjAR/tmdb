part of 'login_status_bloc.dart';

sealed class LoginStatusState {}

final class LoginStatusStateInitial extends LoginStatusState {}

final class LoginStatusStateLoggedIn extends LoginStatusState {}

final class LoginStatusStateLogout extends LoginStatusState {}
