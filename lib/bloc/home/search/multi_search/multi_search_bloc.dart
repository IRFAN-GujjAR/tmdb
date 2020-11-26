import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/bloc/home/search/multi_search/multi_search_events.dart';
import 'package:tmdb/bloc/home/search/multi_search/multi_search_states.dart';
import 'package:tmdb/repositories/home/search/search_repo.dart';

class MultiSearchBloc extends Bloc<MultiSearchEvent, MultiSearchState> {
  final SearchRepo _searchRepo;

  MultiSearchBloc({@required SearchRepo searchRepo})
      : _searchRepo = searchRepo,
        super(MultiSearchState());

  @override
  Stream<MultiSearchState> mapEventToState(MultiSearchEvent event) async* {
    if (event is SearchMultiSearch) {
      yield* _searchMultiSearch(event);
    }
  }

  Stream<MultiSearchState> _searchMultiSearch(SearchMultiSearch event) async* {
    yield MultiSearchLoading();
    try {
      final searches = await _searchRepo.search(event.query, 1);
      yield MultiSearchLoaded(searches: searches);
    } catch (error) {
      yield MultiSearchLoadingError(error: error);
    }
  }
}
