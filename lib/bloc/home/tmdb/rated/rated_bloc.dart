import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/bloc/home/tmdb/rated/rated_events.dart';
import 'package:tmdb/bloc/home/tmdb/rated/rated_states.dart';
import 'package:tmdb/repositories/home/tmdb/rated/rated_repo.dart';

class RatedBloc extends Bloc<RatedEvent, RatedState> {
  final RatedRepo _ratedRepo;

  RatedBloc({@required RatedRepo ratedRepo})
      : _ratedRepo = ratedRepo,
        super(RatedState());

  @override
  Stream<RatedState> mapEventToState(RatedEvent event) async* {
    if (event is LoadRated) {
      yield* _loadRated(event);
    }
  }

  Stream<RatedState> _loadRated(LoadRated event) async* {
    yield RatedLoading();
    try {
      final rated = await _ratedRepo.loadRated(event.user);
      if (rated.isMovies || rated.isTvShows)
        yield RatedLoaded(rated: rated);
      else
        yield RatedEmpty();
    } catch (error) {
      yield RatedLoadingError(error: error);
    }
  }
}
