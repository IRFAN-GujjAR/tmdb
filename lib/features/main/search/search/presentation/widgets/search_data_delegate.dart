// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:provider/provider.dart';
// import 'package:tmdb/features/main/search/details/presentation/blocs/search_details_bloc.dart';
// import 'package:tmdb/features/main/search/details/presentation/pages/search_details_page.dart';
// import 'package:tmdb/features/main/search/details/presentation/providers/search_details_provider.dart';
// import 'package:tmdb/features/main/search/search/domain/use_cases/params/search_params.dart';
// import 'package:tmdb/features/main/search/search/presentation/blocs/search_bloc.dart';
// import 'package:tmdb/features/main/search/search/presentation/widgets/search_suggestions_widget.dart';
//
// class SearchDataDelegate extends SearchDelegate<String?> {
//   final SearchBloc _searchBloc;
//   final SearchDetailsBloc _searchDetailsBloc;
//   final SearchDetailsProvider _searchDetailsProvider;
//
//   SearchDataDelegate({
//     required SearchBloc searchBloc,
//     required SearchDetailsBloc searchDetailsBloc,
//     required SearchDetailsProvider searchDetailsProvider,
//   }) : _searchBloc = searchBloc,
//        _searchDetailsBloc = searchDetailsBloc,
//        _searchDetailsProvider = searchDetailsProvider;
//
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       ),
//     ];
//   }
//
//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: AnimatedIcon(
//         icon: AnimatedIcons.menu_arrow,
//         progress: transitionAnimation,
//       ),
//       onPressed: () {
//         close(context, null);
//       },
//     );
//   }
//
//   @override
//   Widget buildResults(BuildContext context) {
//     _searchDetailsBloc.add(SearchDetailsEventLoad(query));
//     _searchDetailsProvider.setQuery(query);
//     return BlocProvider<SearchDetailsBloc>.value(
//       value: _searchDetailsBloc,
//       child: ChangeNotifierProvider<SearchDetailsProvider>.value(
//         value: _searchDetailsProvider,
//         child: const SearchDetailsPage(),
//       ),
//     );
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     if (query.isNotEmpty)
//       _searchBloc.add(
//         SearchEventLoad(params: SearchParams(query: query, pageNo: 1)),
//       );
//
//     return query.isNotEmpty
//         ? BlocProvider<SearchBloc>.value(
//           value: _searchBloc,
//           child: SearchSuggestionsWidget(
//             query: query,
//             onSubmit: (value) {
//               query = value;
//               showResults(context);
//             },
//           ),
//         )
//         : Center(
//           child: Text(
//             'Search for movies,tv shows, celebrities',
//             style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
//           ),
//         );
//   }
//
//   @override
//   ThemeData appBarTheme(BuildContext context) {
//     final ThemeData theme = Theme.of(context);
//     return theme.copyWith(
//       hintColor: theme.textTheme.titleLarge!.color,
//       inputDecorationTheme: InputDecorationTheme(border: InputBorder.none),
//     );
//   }
// }
