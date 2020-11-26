import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/bloc/home/tmdb/watch_list/watch_list_events.dart';
import 'package:tmdb/bloc/home/tmdb/watch_list/watch_list_states.dart';
import 'package:tmdb/repositories/home/tmdb/watch_list/watch_list_repo.dart';

class WatchListBloc extends Bloc<WatchListEvent, WatchListState> {
  final WatchListRepo _watchListRepo;

  WatchListBloc({@required WatchListRepo watchListRepo})
      : _watchListRepo = watchListRepo,
        super(WatchListState());

  @override
  Stream<WatchListState> mapEventToState(WatchListEvent event) async* {
    if (event is LoadWatchList) {
      yield* _loadWatchList(event);
    }
  }

  Stream<WatchListState> _loadWatchList(LoadWatchList event) async* {
    yield WatchListLoading();
    try {
      final watchList = await _watchListRepo.loadWatchList(event.user);
      if (watchList.isMovies || watchList.isTvShows)
        yield WatchListLoaded(watchList: watchList);
      else
        yield WatchListEmpty();
    } catch (error) {
      yield WatchListLoadingError(error: error);
    }
  }
}
