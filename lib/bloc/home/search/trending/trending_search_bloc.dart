import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/bloc/home/search/trending/trending_search_events.dart';
import 'package:tmdb/bloc/home/search/trending/trending_search_states.dart';
import 'package:tmdb/repositories/home/search/trending_search_repo.dart';

class TrendingSearchBloc
    extends Bloc<TrendingSearchEvents, TrendingSearchState> {
  final TrendingSearchRepo _trendingSearchRepo;

  TrendingSearchBloc({@required TrendingSearchRepo trendingSearchRepo})
      : _trendingSearchRepo = trendingSearchRepo,
        super(TrendingSearchState());

  @override
  Stream<TrendingSearchState> mapEventToState(
      TrendingSearchEvents event) async* {
    switch (event) {
      case TrendingSearchEvents.Load:
        yield* _loadTrendingSearches;
        break;
    }
  }

  Stream<TrendingSearchState> get _loadTrendingSearches async* {
    yield TrendingSearchesLoading();
    try {
      final trendingSearches = await _trendingSearchRepo.loadTrendingSearches;
      yield TrendingSearchesLoaded(trendingSearches: trendingSearches);
    } catch (error) {
      yield TrendingSearchesLoadingError(error: error);
    }
  }
}
