import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmdb/bloc/login/login_events.dart';
import 'package:tmdb/bloc/login/login_states.dart';
import 'package:tmdb/provider/login_info_provider.dart';
import 'package:tmdb/repositories/login/login_repo.dart';
import 'package:tmdb/utils/shared_pref/shared_pref_utils.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepo _loginRepo;
  final LoginInfoProvider _loginInfoProvider;

  LoginBloc(
      {@required LoginRepo loginRepo,
      @required LoginInfoProvider loginInfoProvider})
      : assert(loginRepo != null),
        assert(loginInfoProvider != null),
        _loginRepo = loginRepo,
        _loginInfoProvider = loginInfoProvider,
        super(LoginEmpty());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginUser) yield* _loginUser(event);
  }

  Stream<LoginState> _loginUser(LoginUser event) async* {
    yield LoggingIn();
    try {
      final userInfo = await _loginRepo.login(event.userName, event.password);
      final pref = await SharedPreferences.getInstance();
      await SharedPrefUtils.saveUserDetails(pref, userInfo);
      _loginInfoProvider.signIn(userInfo);
      yield LoggedIn();
    } catch (error) {
      yield LoginError(error: error);
    }
  }
}
