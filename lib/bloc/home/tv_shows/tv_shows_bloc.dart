import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/bloc/home/tv_shows/tv_shows_events.dart';
import 'package:tmdb/bloc/home/tv_shows/tv_shows_states.dart';
import 'package:tmdb/repositories/home/tv_shows/tv_shows_repo.dart';

class TvShowsBloc extends Bloc<TvShowsEvents, TvShowsState> {
  TvShowsRepo _tvShowsRepo;

  TvShowsBloc({@required TvShowsRepo tvShowsRepo})
      : _tvShowsRepo = tvShowsRepo,
        super(TvShowsState());

  @override
  Stream<TvShowsState> mapEventToState(TvShowsEvents event) async* {
    switch (event) {
      case TvShowsEvents.Load:
        yield* _loadTvShows;
        break;
    }
  }

  Stream<TvShowsState> get _loadTvShows async* {
    yield TvShowsLoading();
    try {
      final tvShows = await _tvShowsRepo.loadTvShowsLists;
      yield TvShowsLoaded(tvshowsLists: tvShows);
    } catch (error) {
      yield TvShowsLoadingError(error: error);
    }
  }
}
