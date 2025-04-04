part of '../app_router_utl.dart';

Widget _loginPage(BuildContext context, GoRouterState state) {
  return ChangeNotifierProvider(
    create: (_) => LoginProvider(),
    child: MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) => LoginBloc(
                context.read<AdsManagerBloc>(),
                loginUseCase: LoginUseCase(
                  LoginRepoImpl(
                    LoginDataSourceImpl(CloudFunctionsUtl.tMDBFunction),
                  ),
                ),
                storeUseCase: UserSessionStoreUseCase(
                  UserSessionRepoImpl(UserSessionDataSourceImpl()),
                ),
              ),
        ),
      ],
      child: LoginPage(navigationCategory: state.extra as NavigationCategory),
    ),
  );
}
