part of '../../app_router_utl.dart';

Widget _seeAllCelebsPage(BuildContext context, GoRouterState state) {
  final extra = state.extra as SeeAllCelebsPageExtra;
  return ChangeNotifierProvider<SeeAllCelebsProvider>(
    create:
        (_) => SeeAllCelebsProvider(
          seeAllCelebsBloc: SeeAllCelebsBloc(
            context.read<AdsManagerBloc>(),
            SeeAllCelebsUseCase(
              SeeAllCelebsRepoImpl(
                SeeAllCelebsDataSourceImpl(CloudFunctionsUtl.celebsFunction),
              ),
            ),
          ),
          extra: extra,
        ),
    child: SeeAllCelebsPage(extra),
  );
}
