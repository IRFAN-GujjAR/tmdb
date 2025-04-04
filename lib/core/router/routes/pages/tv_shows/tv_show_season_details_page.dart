part of '../../app_router_utl.dart';

Widget _tvShowSeasonDetailsPage(BuildContext context, GoRouterState state) {
  final extra = state.extra as TvShowSeasonDetailsPageExtra;
  return BlocProvider<TvShowSeasonDetailsBloc>(
    create:
        (_) => TvShowSeasonDetailsBloc(
          context.read<AdsManagerBloc>(),
          TvShowSeasonDetailsUseCase(
            TvShowSeasonDetailsRepoImpl(
              TvShowSeasonDetailsDataSourceImpl(
                CloudFunctionsUtl.tvShowsFunction,
              ),
            ),
          ),
        )..add(
          TvShowSeasonDetailsEventLoad(
            TvShowSeasonDetailsParams(
              tvId: extra.tvId,
              seasonNo: extra.seasonNo,
            ),
          ),
        ),
    child: TvShowSeasonDetailsPage(extra),
  );
}
