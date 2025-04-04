import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/core/entities/error/custom_error_entity.dart';
import 'package:tmdb/core/error/custom_error_utl.dart';
import 'package:tmdb/core/ui/initialize_app.dart';
import 'package:tmdb/features/ads_manager/presentation/blocs/ads_manager_bloc.dart';
import 'package:tmdb/features/app_startup/sub_features/remote_config/domain/entities/remote_config_entity.dart';
import 'package:tmdb/features/app_startup/sub_features/remote_config/domain/use_cases/remote_config_use_case.dart';
import 'package:tmdb/features/app_startup/sub_features/user_session/domain/entities/user_session_entity.dart';
import 'package:tmdb/features/app_startup/sub_features/user_session/domain/use_cases/user_session_load_use_case.dart';

part 'app_startup_event.dart';
part 'app_startup_state.dart';

final class AppStartupBloc extends Bloc<AppStartupEvent, AppStartupState> {
  final AdsManagerBloc _adsManagerBloc;
  final RemoteConfigUseCase _remoteConfigUseCase;
  final UserSessionLoadUseCase _userSessionLoadUseCase;

  AppStartupBloc(
    this._adsManagerBloc,
    this._remoteConfigUseCase,
    this._userSessionLoadUseCase,
  ) : super(AppStartupStateInitial()) {
    on<AppStartupEvent>((event, emit) async {
      switch (event) {
        case AppStartupEvent.LoadRemoteConfig:
          await _onLoadRemoteConfig(event, emit);
          break;
        case AppStartupEvent.LoadUserSession:
          await _onLoadUserSession(event, emit);
          break;
      }
    });
  }

  Future<void> _onLoadRemoteConfig(
    AppStartupEvent event,
    Emitter<AppStartupState> emit,
  ) async {
    emit(AppStartupStateLoadingRemoteConfig());
    try {
      final appVersion = await _remoteConfigUseCase.call;
      AdsManagerBloc.increment(_adsManagerBloc);
      emit(AppStartupStateRemoteConfigLoaded(remoteConfig: appVersion));
    } catch (e) {
      logger.e(e);
      final error = CustomErrorUtl.getError(e);
      AdsManagerBloc.incrementOnError(_adsManagerBloc, error);
      emit(AppStartupStateRemoteConfigError(error));
    }
  }

  Future<void> _onLoadUserSession(
    AppStartupEvent event,
    Emitter<AppStartupState> emit,
  ) async {
    emit(AppStartupStateLoadingUserSession());
    try {
      final userSession = await _userSessionLoadUseCase.call;
      emit(AppStartupStateLoadedUserSession(userSession: userSession));
    } catch (e) {
      logger.e(e);
      emit(AppStartupStateUserSessionError(CustomErrorUtl.getError(e)));
    }
  }
}
