import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/bloc/home/celebrities/see_all/see_all_celebrities_events.dart';
import 'package:tmdb/bloc/home/celebrities/see_all/see_all_celebrities_states.dart';
import 'package:tmdb/models/celebrities_list.dart';
import 'package:tmdb/repositories/home/celebrities/see_all/see_all_celebrities_repo.dart';

class SeeAllCelebritiesBloc
    extends Bloc<SeeAllCelebritiesEvent, SeeAllCelebritiesState> {
  final SeeAllCelebritiesRepo _seeAllCelebritiesRepo;

  SeeAllCelebritiesBloc(
      {@required SeeAllCelebritiesRepo seeAllCelebritiesRepo,
      @required CelebritiesList celebritiesList})
      : _seeAllCelebritiesRepo = seeAllCelebritiesRepo,
        super(SeeAllCelebritiesLoaded(celebrities: celebritiesList));

  @override
  Stream<SeeAllCelebritiesState> mapEventToState(
      SeeAllCelebritiesEvent event) async* {
    if (event is LoadMoreSeeAllCelebrities) {
      yield* _loadMoreCelebrities(event);
    }
  }

  Stream<SeeAllCelebritiesState> _loadMoreCelebrities(
      LoadMoreSeeAllCelebrities event) async* {
    yield SeeAllCelebritiesLoadingMore(celebrities: event.previousCelebrities);
    try {
      final celebritiesList =
          await _seeAllCelebritiesRepo.loadMoreCelebrities(event);
      yield SeeAllCelebritiesLoaded(celebrities: celebritiesList);
    } catch (error) {
      yield SeeAllCelebritiesError(
          celebrities: event.previousCelebrities, error: error);
    }
  }

  CelebritiesList get celebritiesList {
    final seeAllCelebritiesState = state;
    if (seeAllCelebritiesState is SeeAllCelebritiesLoaded) {
      return seeAllCelebritiesState.celebrities;
    } else if (seeAllCelebritiesState is SeeAllCelebritiesLoadingMore) {
      return seeAllCelebritiesState.celebrities;
    } else {
      return (seeAllCelebritiesState as SeeAllCelebritiesError).celebrities;
    }
  }
}
