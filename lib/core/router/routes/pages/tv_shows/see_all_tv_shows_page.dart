part of '../../app_router_utl.dart';

Widget _seeAllTvShowsPage(BuildContext context, GoRouterState state) {
  return ChangeNotifierProvider(
    create:
        (_) => SeeAllTvShowsProvider(
          seeAllTvShowsBloc: SeeAllTvShowsBloc(
            context.read<AdsManagerBloc>(),
            SeeAllTvShowsUseCase(
              SeeAllTvShowsRepoImpl(
                SeeAllTvShowsDataSourceImpl(CloudFunctionsUtl.tvShowsFunction),
              ),
            ),
          ),
          extra: state.extra as SeeAllTvShowsPageExtra,
        ),
    child: const SeeAllTvShowsPage(),
  );
}
