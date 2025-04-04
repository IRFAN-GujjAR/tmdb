part of 'login_status_bloc.dart';

sealed class LoginStatusEvent {}

final class LoginStatusEventLogin extends LoginStatusEvent {}

final class LoginStatusEventLogout extends LoginStatusEvent {}
