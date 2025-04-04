part of '../../app_router_utl.dart';

Widget _celebrityDetailsPage(BuildContext context, GoRouterState state) {
  final extra = state.extra as CelebrityDetailsPageExtra;

  return BlocProvider<CelebrityDetailsBloc>(
    create:
        (_) => CelebrityDetailsBloc(
          context.read<AdsManagerBloc>(),
          CelebrityDetailsUseCase(
            CelebritiesDetailsRepoImpl(
              CelebritiesDetailsDataSourceImpl(
                CloudFunctionsUtl.celebsFunction,
              ),
            ),
          ),
        )..add(CelebrityDetailsEventLoad(extra.id)),
    child: CelebrityDetailsPage(extra),
  );
}
