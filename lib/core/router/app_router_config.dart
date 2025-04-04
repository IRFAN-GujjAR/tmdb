import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tmdb/core/router/routes/app_router_nav_keys.dart';
import 'package:tmdb/core/router/routes/app_router_utl.dart';

final class AppRouterConfig {
  final AppRouterNavKeys _navKeys = AppRouterNavKeys();
  AppRouterNavKeys get navKeys => _navKeys;

  late GoRouter _appRouter;
  GoRouter get appRouter => _appRouter;

  AppRouterConfig() {
    _appRouter = AppRouterUtl().appRouter(navKeys: navKeys);
  }

  void go(BuildContext context, {required String location, Object? extra}) {
    GoRouter.of(context).go(location, extra: extra);
  }

  void push(BuildContext context, {required String location, Object? extra}) {
    GoRouter.of(context).push(location, extra: extra);
  }

  void pop(BuildContext context) {
    GoRouter.of(context).pop();
  }

  Object? getExtra(BuildContext context) {
    return GoRouter.of(context).state.extra;
  }
}
