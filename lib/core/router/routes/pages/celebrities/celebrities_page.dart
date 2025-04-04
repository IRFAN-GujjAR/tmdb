part of '../../app_router_utl.dart';

Widget _celebritiesPage(BuildContext context) {
  final repo = CelebritiesRepoImpl(
    CelebritiesLocalDataSourceImpl(CelebsDao(appDatabase)),
    CelebritiesRemoteDataSourceImpl(CloudFunctionsUtl.celebsFunction),
  );
  return BlocProvider(
    create:
        (_) => CelebritiesBloc(
          context.read<AdsManagerBloc>(),
          CelebritiesUseCaseWatch(repo),
          CelebritiesUseCaseLoad(repo),
        )..add(CelebritiesEventLoad()),
    child: const CelebritiesPage(),
  );
}
