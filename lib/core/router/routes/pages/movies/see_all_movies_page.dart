part of '../../app_router_utl.dart';

Widget _seeAllMoviesPage(BuildContext context, GoRouterState state) {
  return ChangeNotifierProvider(
    create:
        (_) => SeeAllMoviesProvider(
          seeAllMoviesBloc: SeeAllMoviesBloc(
            context.read<AdsManagerBloc>(),
            SeeAllMoviesUseCase(
              SeeAllMoviesRepoImpl(
                SeeAllMoviesDataSourceImpl(CloudFunctionsUtl.moviesFunction),
              ),
            ),
          ),
          extra: state.extra as SeeAllMoviesPageExtra,
        ),
    child: const SeeAllMoviesPage(),
  );
}
