part of '../../app_router_utl.dart';

Widget _tMDBMediaListPage(BuildContext context, GoRouterState state) {
  final user = context.read<UserSessionProvider>().userSession;
  final listCategory = state.extra as TMDbMediaListCFCategory;
  final paramsData = TMDbMediaListCfParamsData(
    listCategory: listCategory,
    listType: TMDbMediaListTypeCFCategory.both,
    userId: user.userId,
    sessionId: user.sessionId,
    pageNo: 1,
    sortBy: SortByCFCategory.desc,
  );
  return BlocProvider(
    create:
        (_) => TMDbMediaListBloc(
          context.read<AdsManagerBloc>(),
          TMDbMediaListUseCase(
            TMDbMediaListRepoImpl(
              TMDbMediaListDataSourceImpl(CloudFunctionsUtl.tMDBFunction),
            ),
          ),
        )..add(TMDbMediaListEventLoad(paramsData)),
    child: MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TMDbMediaListScrollControllerProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TMDbMediaListProvider(paramsData: paramsData),
        ),
      ],
      child: TMDbMediaListPage(listCategory),
    ),
  );
}
