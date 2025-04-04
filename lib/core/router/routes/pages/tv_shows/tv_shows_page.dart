part of '../../app_router_utl.dart';

Widget _tvShowsPage(BuildContext context) {
  final repo = TVShowsRepoImpl(
    TvShowsLocalDataSourceImpl(TvShowsDao(appDatabase)),
    TvShowsRemoteDataSourceImpl(CloudFunctionsUtl.tvShowsFunction),
  );
  return BlocProvider(
    create:
        (_) => TvShowsBloc(
          context.read<AdsManagerBloc>(),
          TvShowsUseCaseWatch(repo),
          TvShowsUseCaseLoad(repo),
        )..add(TvShowsEventLoad()),
    child: const TvShowsPage(),
  );
}
