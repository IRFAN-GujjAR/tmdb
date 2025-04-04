part of '../app_router_utl.dart';

Widget _ratePage(BuildContext context, GoRouterState state) {
  return BlocProvider(
    create:
        (context) => RateMediaBloc(
          context.read<AdsManagerBloc>(),
          rateMediaRepo: RateMediaRepoImpl(
            RateMediaDataSourceImpl(CloudFunctionsUtl.tMDBFunction),
          ),
        ),
    child: ChangeNotifierProvider(
      create:
          (BuildContext context) => RateProvider(state.extra as RatePageExtra),
      child: const RatePage(),
    ),
  );
}
