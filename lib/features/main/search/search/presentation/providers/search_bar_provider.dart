import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/features/main/search/details/presentation/providers/search_details_provider.dart';
import 'package:tmdb/features/main/search/search/domain/use_cases/params/search_params.dart';
import 'package:tmdb/features/main/search/search/presentation/blocs/search_bloc.dart';

enum SearchPageType { Trending, Suggestions, Details }

final class SearchBarProvider extends ChangeNotifier {
  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;
  FocusNode _focusNode = FocusNode();
  FocusNode get focusNode => _focusNode;
  void get unFocus {
    if (_focusNode.hasPrimaryFocus || _focusNode.hasFocus) {
      _focusNode.unfocus();
    }
  }

  String get query => _searchController.text.trim();

  bool _showSearch = false;
  bool get showSearch => _showSearch;
  set setShowSearch(bool value) {
    _showSearch = value;
    notifyListeners();
  }

  SearchPageType _searchPageType = SearchPageType.Trending;
  SearchPageType get searchPageType => _searchPageType;
  set setSearchPageType(SearchPageType value) {
    _searchPageType = value;
    notifyListeners();
  }

  void onSubmit(BuildContext context, String value) {
    if (_searchController.text != value) _searchController.text = value;
    context.read<SearchDetailsProvider>().load(context, value);
    _searchPageType = SearchPageType.Details;
    notifyListeners();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void onChanged(BuildContext context, String query) {
    if (query.isNotEmpty)
      context.read<SearchBloc>().add(
        SearchEventLoad(params: SearchParams(query: query, pageNo: 1)),
      );
    _searchPageType = SearchPageType.Suggestions;
    context.read<SearchDetailsProvider>().clearDetails;
    notifyListeners();
  }

  void closeSearch(BuildContext context) {
    _showSearch = false;
    _searchPageType = SearchPageType.Trending;
    _searchController.clear();
    context.read<SearchDetailsProvider>().clearDetails;
    notifyListeners();
  }

  void onTrendingItemPressed(BuildContext context, String searchTitle) {
    _showSearch = true;
    onSubmit(context, searchTitle);
  }

  void onSuggestItemPressed(BuildContext context, String searchTitle) {
    onSubmit(context, searchTitle);
  }
}
