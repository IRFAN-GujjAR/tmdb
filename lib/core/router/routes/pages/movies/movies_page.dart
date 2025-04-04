part of '../../app_router_utl.dart';

Widget _moviesPage(BuildContext context) {
  final moviesRepo = MoviesRepoImpl(
    MoviesLocalDataSourceImpl(MoviesDao(appDatabase)),
    MoviesRemoteDataSourceImpl(CloudFunctionsUtl.moviesFunction),
  );
  return BlocProvider(
    create:
        (_) => MoviesBloc(
          context.read<AdsManagerBloc>(),
          moviesUseCase: MoviesUseCaseLoad(moviesRepo),
          moviesUseCaseWatch: MoviesUseCaseWatch(moviesRepo),
        )..add(MoviesEventLoad()),
    child: MoviesPage(),
  );
}
