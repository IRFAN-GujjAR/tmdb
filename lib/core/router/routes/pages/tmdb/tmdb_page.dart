part of '../../app_router_utl.dart';

Widget _tMDBPage(BuildContext context) {
  final repo = AccountDetailsRepoImpl(
    AccountDetailsLocalDataSourceImpl(AccountDetailsDao(appDatabase)),
    AccountDetailsRemoteDataSourceImpl(CloudFunctionsUtl.tMDBFunction),
  );
  final tmdbBloc = TMDbBloc(
    context.read<AdsManagerBloc>(),
    AccountDetailsUseCaseWatch(repo),
    AccountDetailsUseCaseLoad(repo),
    AccountDetailsUseCaseDelete(repo),
    UserSessionDeleteUseCase(UserSessionRepoImpl(UserSessionDataSourceImpl())),
  );
  final provider = context.read<UserSessionProvider>();
  if (provider.isLoggedIn)
    tmdbBloc.add(TMDbEventLoadAccountDetails(provider.userSession.sessionId));
  return BlocProvider.value(value: tmdbBloc, child: const TMDbPage());
}
