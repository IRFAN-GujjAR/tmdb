part of 'app_startup_bloc.dart';

sealed class AppStartupState extends Equatable {
  const AppStartupState();
}

final class AppStartupStateInitial extends AppStartupState {
  @override
  List<Object?> get props => [];
}

//Remote Config
final class AppStartupStateLoadingRemoteConfig extends AppStartupState {
  @override
  List<Object?> get props => [];
}

final class AppStartupStateRemoteConfigLoaded extends AppStartupState {
  final RemoteConfigEntity remoteConfig;

  AppStartupStateRemoteConfigLoaded({required this.remoteConfig});

  @override
  List<Object?> get props => [remoteConfig];
}

final class AppStartupStateRemoteConfigError extends AppStartupState {
  final CustomErrorEntity error;

  AppStartupStateRemoteConfigError(this.error);

  @override
  List<Object?> get props => [error];
}

//User Session
final class AppStartupStateLoadingUserSession extends AppStartupState {
  @override
  List<Object?> get props => [];
}

final class AppStartupStateLoadedUserSession extends AppStartupState {
  final UserSessionEntity userSession;

  AppStartupStateLoadedUserSession({required this.userSession});

  @override
  List<Object?> get props => [userSession];
}

final class AppStartupStateUserSessionError extends AppStartupState {
  final CustomErrorEntity error;

  AppStartupStateUserSessionError(this.error);

  @override
  List<Object?> get props => [error];
}
