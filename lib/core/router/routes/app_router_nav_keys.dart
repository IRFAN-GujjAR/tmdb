import 'package:flutter/material.dart';

final class AppRouterNavKeys {
  final GlobalKey<NavigatorState> _rootNavKey = GlobalKey<NavigatorState>(
    debugLabel: 'root',
  );
  GlobalKey<NavigatorState> get rootNavKey => _rootNavKey;

  final GlobalKey<NavigatorState> _moviesNavKey = GlobalKey<NavigatorState>(
    debugLabel: 'movies',
  );
  GlobalKey<NavigatorState> get moviesNavKey => _moviesNavKey;

  final GlobalKey<NavigatorState> _tvShowsNavKey = GlobalKey<NavigatorState>(
    debugLabel: 'tv_shows',
  );
  GlobalKey<NavigatorState> get tvShowsNavKey => _tvShowsNavKey;

  final GlobalKey<NavigatorState> _celebritiesNavKey =
      GlobalKey<NavigatorState>(
    debugLabel: 'celebrities',
  );
  GlobalKey<NavigatorState> get celebritiesNavKey => _celebritiesNavKey;

  final GlobalKey<NavigatorState> _searchNavKey = GlobalKey<NavigatorState>(
    debugLabel: 'search',
  );
  GlobalKey<NavigatorState> get searchNavKey => _searchNavKey;

  final GlobalKey<NavigatorState> _tMDBNavKey = GlobalKey<NavigatorState>(
    debugLabel: 'tmdb',
  );
  GlobalKey<NavigatorState> get tMDBNavKey => _tMDBNavKey;

  final GlobalKey<NavigatorState> _detailsNavKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get detailsNavKey => _detailsNavKey;
}
