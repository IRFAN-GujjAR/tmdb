import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/bloc/login/login_state/login_state_events.dart';
import 'package:tmdb/bloc/login/login_state/login_state_states.dart';

class LoginStateBloc extends Bloc<LoginStateEvents, LoginStateState> {
  LoginStateBloc() : super(LoginStateState());

  @override
  Stream<LoginStateState> mapEventToState(LoginStateEvents event) async* {
    switch (event) {
      case LoginStateEvents.Login:
        yield LoginStateLoggedIn();
        break;
      case LoginStateEvents.Logout:
        yield LoginStateLogout();
        break;
    }
  }
}
