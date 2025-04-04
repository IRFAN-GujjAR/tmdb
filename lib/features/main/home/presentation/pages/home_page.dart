import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum TabItem { movies, tvShows, celebs, search, account }

Map<TabItem, String> tabName = {
  TabItem.movies: 'Movies',
  TabItem.tvShows: 'Tv Shows',
  TabItem.celebs: 'Celebrities',
  TabItem.search: 'Search',
  TabItem.account: 'TMDB',
};

class HomePage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  HomePage({required this.navigationShell, Key? key})
    : super(key: key ?? const ValueKey<String>('HomePage'));

  final List<NavigationDestination> _destinations = [
    NavigationDestination(
      label: tabName[TabItem.movies]!,
      icon: Icon(Icons.local_movies, color: Colors.grey),
      selectedIcon: Icon(Icons.local_movies),
    ),
    NavigationDestination(
      label: tabName[TabItem.tvShows]!,
      icon: Icon(Icons.tv, color: Colors.grey),
      selectedIcon: Icon(Icons.tv),
    ),
    NavigationDestination(
      label: tabName[TabItem.celebs]!,
      icon: Icon(Icons.person, color: Colors.grey),
      selectedIcon: Icon(Icons.person),
    ),
    NavigationDestination(
      label: tabName[TabItem.search]!,
      icon: Icon(Icons.search, color: Colors.grey),
      selectedIcon: Icon(Icons.search),
    ),
    NavigationDestination(
      label: tabName[TabItem.account]!,
      icon: Icon(Icons.account_box, color: Colors.grey),
      selectedIcon: Icon(Icons.account_box),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The StatefulNavigationShell from the associated StatefulShellRoute is
      // directly passed as the body of the Scaffold.
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        destinations: _destinations,
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          _onTap(context, index);
        },
      ),
    );
  }
  // #enddocregion configuration-custom-shell

  /// NOTE: For a slightly more sophisticated branch switching, change the onTap
  /// handler on the BottomNavigationBar above to the following:
  /// `onTap: (int index) => _onTap(context, index),`
  // ignore: unused_element
  void _onTap(BuildContext context, int index) {
    // When navigating to a new branch, it's recommended to use the goBranch
    // method, as doing so makes sure the last navigation state of the
    // Navigator for the branch is restored.
    if (index == navigationShell.currentIndex) {
      navigationShell.goBranch(
        index,
        // A common pattern when using bottom navigation bars is to support
        // navigating to the initial location when tapping the item that is
        // already active. This example demonstrates how to support this behavior,
        // using the initialLocation parameter of goBranch.
        initialLocation: index == navigationShell.currentIndex,
      );
    } else {
      navigationShell.goBranch(index);
    }
  }
}
