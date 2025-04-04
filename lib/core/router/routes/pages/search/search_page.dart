part of '../../app_router_utl.dart';

Widget _searchPage(BuildContext context) {
  final repo = TrendingSearchRepoImpl(
    TrendingSearchLocalDataSourceImpl(TrendingSearchDao(appDatabase)),
    TrendingSearchRemoteDataSourceImpl(CloudFunctionsUtl.searchFunction),
  );
  final adsManagerBloc = context.read<AdsManagerBloc>();
  return MultiBlocProvider(
    providers: [
      BlocProvider(
        create:
            (_) => TrendingSearchBloc(
              adsManagerBloc,
              TrendingSearchUseCaseWatch(repo),
              TrendingSearchUseCaseLoad(repo),
            )..add(const TrendingSearchEventLoad()),
      ),
      BlocProvider(
        create:
            (context) => SearchBloc(
              adsManagerBloc,
              SearchUseCase(
                SearchRepoImpl(
                  SearchDataSourceImpl(CloudFunctionsUtl.searchFunction),
                ),
              ),
            ),
      ),
      BlocProvider(
        create:
            (_) => SearchDetailsBloc(
              adsManagerBloc,
              SearchDetailsUseCase(
                SearchDetailsRepoImpl(
                  SearchDetailsDataSourceImpl(CloudFunctionsUtl.searchFunction),
                ),
              ),
            ),
      ),
      ChangeNotifierProvider(create: (_) => SearchDetailsProvider()),
      ChangeNotifierProvider(create: (_) => SearchBarProvider()),
    ],
    child: const SearchPage(),
  );
}
