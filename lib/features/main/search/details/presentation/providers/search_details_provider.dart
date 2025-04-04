import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/features/main/search/details/domain/entities/search_details_entity.dart';
import 'package:tmdb/features/main/search/details/presentation/blocs/search_details_bloc.dart';

class SearchDetailsProvider extends ChangeNotifier {
  String _query = '';
  String get query => _query;
  void setQuery(String query) {
    _query = query;
  }

  SearchDetailsState _state = SearchDetailsStateInitial();
  SearchDetailsState get state => _state;

  TabController? _tabController;
  TabController? get tabController => _tabController;

  void onSearchDetailsBlocStateChanged(
    SearchDetailsState state,
    TickerProvider vsync,
  ) {
    switch (state) {
      case SearchDetailsStateInitial():
        _updateState(state);
        break;
      case SearchDetailsStateLoading():
        _updateState(state);
        break;
      case SearchDetailsStateLoaded():
        _onDetailsLoaded(vsync, state);
        break;
      case SearchDetailsStateNoResultsFound():
        _updateState(state);
        break;
      case SearchDetailsStateError():
        _updateState(state);
        break;
    }
  }

  void _updateState(SearchDetailsState state) {
    _state = state;
    notifyListeners();
  }

  void _onDetailsLoaded(TickerProvider vsync, SearchDetailsStateLoaded state) {
    _initializeTabController(vsync, state.searchDetails);
    _updateState(state);
  }

  void _initializeTabController(
    TickerProvider vsync,
    SearchDetailsEntity searchDetails,
  ) {
    _tabController?.dispose();
    _tabController = TabController(
      length: _getTabControllerLength(searchDetails),
      vsync: vsync,
    );
    _updateState(state);
  }

  int _getTabControllerLength(SearchDetailsEntity searchDetails) {
    int length = 0;
    if (searchDetails.isAll) {
      length = 4;
    } else {
      if (searchDetails.isMovies) {
        length++;
      }
      if (searchDetails.isTvShows) {
        length++;
      }
      if (searchDetails.isCelebrities) {
        length++;
      }
    }
    return length;
  }

  void changeTabControllerIndex(int index) {
    _tabController?.animateTo(index);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  void get clearDetails {
    _state = SearchDetailsStateInitial();
    _tabController?.dispose();
    _tabController = null;
    notifyListeners();
  }

  void load(BuildContext context, String query) {
    if (query != _query) {
      setQuery(query);
      context.read<SearchDetailsBloc>().add(SearchDetailsEventLoad(query));
    }
  }
}
