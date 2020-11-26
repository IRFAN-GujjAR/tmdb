import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginEmpty extends LoginState {}

class LoggingIn extends LoginState {}

class LoggedIn extends LoginState {}

class LoginError extends LoginState {
  final dynamic error;

  const LoginError({@required this.error});
}
