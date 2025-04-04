part of '../../app_router_utl.dart';

Widget _movieDetailsPage(BuildContext context, GoRouterState state) {
  final extra = state.extra as MovieDetailsPageExtra;
  final adsManagerBloc = context.read<AdsManagerBloc>();
  return MultiBlocProvider(
    providers: [
      BlocProvider<MovieDetailsBloc>(
        create:
            (context) => MovieDetailsBloc(
              adsManagerBloc,
              MovieDetailsUseCase(
                MovieDetailsRepoImpl(
                  MovieDetailsDataSourceImpl(CloudFunctionsUtl.moviesFunction),
                ),
              ),
            )..add(MovieDetailsEventLoad(extra.id)),
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
    child: MovieDetailsPage(extra),
  );
}
