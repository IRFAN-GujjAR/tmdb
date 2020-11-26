import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginUser extends LoginEvent {
  final String userName, password;

  const LoginUser({@required this.userName, @required this.password});

  @override
  List<Object> get props => [userName, password];
}
