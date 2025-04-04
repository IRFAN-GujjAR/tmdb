import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/core/entities/error/custom_error_entity.dart';
import 'package:tmdb/core/error/custom_error_utl.dart';
import 'package:tmdb/core/ui/initialize_app.dart';
import 'package:tmdb/features/ads_manager/presentation/blocs/ads_manager_bloc.dart';
import 'package:tmdb/features/login/domain/use_cases/login_use_case.dart';
import 'package:tmdb/features/login/domain/use_cases/params/login_params.dart';

import '../../../app_startup/sub_features/user_session/domain/entities/user_session_entity.dart';
import '../../../app_startup/sub_features/user_session/domain/use_cases/user_session_store_use_case.dart';

part 'login_events.dart';
part 'login_states.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AdsManagerBloc _adsManagerBloc;
  final LoginUseCase _loginUseCase;
  final UserSessionStoreUseCase _storeUseCase;

  LoginBloc(
    this._adsManagerBloc, {
    required LoginUseCase loginUseCase,
    required UserSessionStoreUseCase storeUseCase,
  }) : _loginUseCase = loginUseCase,
       _storeUseCase = storeUseCase,
       super(LoginStateEmpty()) {
    on<LoginEvent>((event, emit) async {
      switch (event) {
        case LoginEventUser():
          await _onLogin(event, emit);
          break;
      }
    });
  }

  Future<void> _onLogin(LoginEventUser event, Emitter<LoginState> emit) async {
    emit(LoginStateLoggingIn());
    try {
      final userInfo = await _loginUseCase.call(
        LoginParams(event.userName, event.password),
      );
      await _storeUseCase.call(
        UserSessionEntity(
          userId: userInfo.userId,
          username: userInfo.username,
          sessionId: userInfo.sessionId,
        ),
      );
      AdsManagerBloc.increment(_adsManagerBloc);
      emit(LoginStateLoggedIn(userInfo));
    } catch (e) {
      logger.e(e);
      final error = CustomErrorUtl.getError(e);
      AdsManagerBloc.incrementOnError(_adsManagerBloc, error);
      emit(LoginStateError(error));
    }
  }
}
