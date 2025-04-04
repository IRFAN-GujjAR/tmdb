import 'package:flutter_bloc/flutter_bloc.dart';
part 'login_status_events.dart';
part 'login_status_states.dart';

class LoginStatusBloc extends Bloc<LoginStatusEvent, LoginStatusState> {
  LoginStatusBloc() : super(LoginStatusStateInitial()) {
    on<LoginStatusEventLogin>(
        (event, emit) => emit(LoginStatusStateLoggedIn()));
    on<LoginStatusEventLogout>(
        ((event, emit) => emit(LoginStatusStateLogout())));
  }
}
