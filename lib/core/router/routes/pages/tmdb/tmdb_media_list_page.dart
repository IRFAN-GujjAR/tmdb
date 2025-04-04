part of '../../app_router_utl.dart';

Widget _tMDBMediaListPage(BuildContext context, GoRouterState state) {
  final user = context.read<UserSessionProvider>().userSession;
  final listCategory = state.extra as TMDbMediaListCFCategory;
  return BlocProvider(
    create:
        (_) => TMDbMediaListBloc(
          context.read<AdsManagerBloc>(),
          TMDbMediaListUseCase(
            TMDbMediaListRepoImpl(
              TMDbMediaListDataSourceImpl(CloudFunctionsUtl.tMDBFunction),
            ),
          ),
        )..add(
          TMDbMediaListEventLoad(
            TMDbMediaListCfParamsData(
              listCategory: listCategory,
              listType: TMDbMediaListTypeCFCategory.both,
              userId: user.userId,
              sessionId: user.sessionId,
              pageNo: 1,
              sortBy: SortByCFCategory.asc,
            ),
          ),
        ),
    child: ChangeNotifierProvider(
      create: (_) => TMDbMediaListScrollControllerProvider(),
      child: TMDbMediaListPage(listCategory),
    ),
  );
}
