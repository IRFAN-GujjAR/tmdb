import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/bloc/home/search/details/search_details_events.dart';
import 'package:tmdb/bloc/home/search/details/search_details_states.dart';
import 'package:tmdb/repositories/home/search/details/search_details_repo.dart';

class SearchDetailsBloc extends Bloc<SearchDetailsEvent, SearchDetailsState> {
  final SearchDetailsRepo _searchDetailsRepo;

  SearchDetailsBloc({@required SearchDetailsRepo searchDetailsRepo})
      : _searchDetailsRepo = searchDetailsRepo,
        super(SearchDetailsState());

  @override
  Stream<SearchDetailsState> mapEventToState(SearchDetailsEvent event) async* {
    if (event is LoadSearchDetails) {
      yield* _loadSearchDetails(event);
    }
  }

  Stream<SearchDetailsState> _loadSearchDetails(
      LoadSearchDetails event) async* {
    yield SearchDetailsLoading();
    try {
      final searchDetails =
          await _searchDetailsRepo.loadSearchDetails(event.query);
      if (searchDetails.isMovies ||
          searchDetails.isTvShows ||
          searchDetails.isCelebrities)
        yield SearchDetailsLoaded(searchDetails: searchDetails);
      else
        yield SearchDetailsEmpty();
    } catch (error) {
      yield SearchDetailsLoadingError(error: error);
    }
  }
}
