import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/bloc/home/search/multi_search/multi_search_bloc.dart';
import 'package:tmdb/bloc/home/search/multi_search/multi_search_events.dart';
import 'package:tmdb/ui/bottom_navigation/search/search_widget.dart';

import 'details/search_details.dart';

class SearchDataDelegate extends SearchDelegate<String> {
  final MultiSearchBloc _multiSearchBloc;

  SearchDataDelegate({@required MultiSearchBloc multiSearchBloc})
      : _multiSearchBloc = multiSearchBloc;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchDetails(
      typedText: query,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query != null && query.isNotEmpty)
      _multiSearchBloc.add(SearchMultiSearch(query: query));

    return query != null && query.isNotEmpty
        ? BlocProvider.value(
            value: _multiSearchBloc,
            child: SearchWidget(
                query: query,
                onSubmit: (value) {
                  query = value;
                  showResults(context);
                }))
        : Center(
            child: Text(
              'Search for movies,tv shows, celebrities',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
            ),
          );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
        inputDecorationTheme: InputDecorationTheme(
            hintStyle:
                TextStyle(color: theme.primaryTextTheme.headline6.color)),
        primaryColor: theme.primaryColor,
        primaryIconTheme: theme.primaryIconTheme,
        primaryColorBrightness: theme.primaryColorBrightness,
        primaryTextTheme: theme.primaryTextTheme,
        textTheme: theme.textTheme.copyWith(
            headline6: theme.textTheme.headline6
                .copyWith(color: theme.primaryTextTheme.headline6.color)));
  }
}
