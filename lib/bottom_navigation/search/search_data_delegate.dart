import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/network/search_api.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/rendering.dart';

import 'details/search_details.dart';

class SearchDataDelegate extends SearchDelegate<String> {

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
    return query != null && query.isNotEmpty
        ? FutureBuilder(
            future: getSearchQueries(http.Client(), query),
            builder: (BuildContext context,
                AsyncSnapshot<List<String>> searchQueries) {
              if (searchQueries.hasError) {
                print(searchQueries.error);
              }

              return searchQueries.hasData
                  ? Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                      child: ListView.builder(
                          itemCount: searchQueries.data.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                                onTap: () {
                                  query = searchQueries.data[index];
                                  showResults(context);
                                },
                                leading: Icon(Icons.search),
                                title: Text(searchQueries.data[index]));
                          }),
                    )
                  : Center(child: CircularProgressIndicator());
            },
          )
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
            hintStyle: TextStyle(color: theme.primaryTextTheme.title.color)),
        primaryColor: theme.primaryColor,
        primaryIconTheme: theme.primaryIconTheme,
        primaryColorBrightness: theme.primaryColorBrightness,
        primaryTextTheme: theme.primaryTextTheme,
        textTheme: theme.textTheme.copyWith(
            title: theme.textTheme.title
                .copyWith(color: theme.primaryTextTheme.title.color)));
  }
}
