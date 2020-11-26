import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/bloc/home/tv_shows/details/see_all/see_all_tv_shows_events.dart';
import 'package:tmdb/bloc/home/tv_shows/details/see_all/see_all_tv_shows_states.dart';
import 'package:tmdb/models/tv_shows_list.dart';
import 'package:tmdb/repositories/home/tv_shows/see_all/see_all_tv_shows_repo.dart';

class SeeAllTvShowsBloc extends Bloc<SeeAllTvShowsEvent, SeeAllTvShowsState> {
  final SeeAllTvShowsRepo _seeAllTvShowsRepo;

  SeeAllTvShowsBloc(
      {@required SeeAllTvShowsRepo seeAllTvShowsRepo,
      @required TvShowsList tvShowsList})
      : _seeAllTvShowsRepo = seeAllTvShowsRepo,
        super(SeeAllTvShowsLoaded(tvShowsList: tvShowsList));

  @override
  Stream<SeeAllTvShowsState> mapEventToState(SeeAllTvShowsEvent event) async* {
    if (event is LoadMoreSeeAllTvShows) {
      yield* _loadMoreTvShows(event);
    }
  }

  Stream<SeeAllTvShowsState> _loadMoreTvShows(
      LoadMoreSeeAllTvShows event) async* {
    yield SeeAllTvShowsLoadingMore(tvShowsList: event.previousTvShows);
    try {
      final tvShowsList = await _seeAllTvShowsRepo.loadMoreTvShows(event);
      yield SeeAllTvShowsLoaded(tvShowsList: tvShowsList);
    } catch (error) {
      yield SeeAllTvShowsError(
          tvShowsList: event.previousTvShows, error: error);
    }
  }

  TvShowsList get tvShowsList {
    final seeAllTvShowsState = state;
    if (seeAllTvShowsState is SeeAllTvShowsLoaded) {
      return seeAllTvShowsState.tvShowsList;
    } else if (seeAllTvShowsState is SeeAllTvShowsLoadingMore) {
      return seeAllTvShowsState.tvShowsList;
    } else {
      return (seeAllTvShowsState as SeeAllTvShowsError).tvShowsList;
    }
  }
}
