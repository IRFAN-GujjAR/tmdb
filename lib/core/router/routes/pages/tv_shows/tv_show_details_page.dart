part of '../../app_router_utl.dart';

Widget _tvShowDetailsPage(BuildContext context, GoRouterState state) {
  final extra = state.extra as TvShowDetailsPageExtra;
  final adsManagerBloc = context.read<AdsManagerBloc>();
  return MultiBlocProvider(
    providers: [
      BlocProvider<TvShowDetailsBloc>(
        create:
            (context) => TvShowDetailsBloc(
              adsManagerBloc,
              TvShowDetailsUseCase(
                TvShowDetailsRepoImpl(
                  TvShowDetailsDataSourceImpl(
                    CloudFunctionsUtl.tvShowsFunction,
                  ),
                ),
              ),
            )..add(TvShowDetailsEventLoad(tvId: extra.id)),
      ),
      BlocProvider<MediaStateBloc>(
        create:
            (context) => MediaStateBloc(
              adsManagerBloc,
              MediaStateUseCase(
                MediaStateRepoImpl(
                  MediaStateDataSourceImpl(CloudFunctionsUtl.tMDBFunction),
                ),
              ),
            ),
      ),
      BlocProvider<MediaStateChangesBloc>(
        create: (context) => MediaStateChangesBloc(),
      ),
    ],
    child: TvShowDetailsPage(extra),
  );
}
