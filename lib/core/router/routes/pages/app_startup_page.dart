part of '../app_router_utl.dart';

Widget _appStartupPage(BuildContext context) {
  return MultiBlocProvider(
    providers: [
      BlocProvider(
        create:
            (_) => AppStartupBloc(
              context.read<AdsManagerBloc>(),
              RemoteConfigUseCase(
                RemoteConfigRepoImpl(
                  RemoteConfigDataSourceImpl(FirebaseRemoteConfig.instance),
                ),
              ),
              UserSessionLoadUseCase(
                UserSessionRepoImpl(UserSessionDataSourceImpl()),
              ),
            )..add(AppStartupEvent.LoadRemoteConfig),
      ),
      ChangeNotifierProvider<AppStartupProvider>(
        create: (_) => AppStartupProvider(),
      ),
    ],
    child: const AppStartupPage(),
  );
}
