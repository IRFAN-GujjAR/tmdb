part of '../../app_router_utl.dart';

Widget _movieCollectionDetailsPage(BuildContext context, GoRouterState state) {
  final extra = state.extra as MovieCollectionDetailsPageExtra;
  return BlocProvider<MovieCollectionDetailsBloc>(
    create:
        (_) => MovieCollectionDetailsBloc(
          context.read<AdsManagerBloc>(),
          MovieCollectionDetailsUseCase(
            MovieCollectionDetailsRepoImpl(
              MovieCollectionDetailsDataSourceImpl(
                CloudFunctionsUtl.moviesFunction,
              ),
            ),
          ),
        )..add(MovieCollectionDetailsEventLoad(extra.id)),
    child: MovieCollectionDetailsPage(extra),
  );
}
