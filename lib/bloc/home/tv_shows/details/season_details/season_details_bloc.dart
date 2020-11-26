import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/bloc/home/tv_shows/details/season_details/season_details_events.dart';
import 'package:tmdb/bloc/home/tv_shows/details/season_details/season_details_states.dart';
import 'package:tmdb/repositories/home/tv_shows/tv_show_details/season_details/season_details_repo.dart';

class SeasonDetailsBloc extends Bloc<SeasonDetailsEvent, SeasonDetailsState> {
  final SeasonDetailsRepo _seasonDetailsRepo;

  SeasonDetailsBloc({@required SeasonDetailsRepo seasonDetailsRepo})
      : _seasonDetailsRepo = seasonDetailsRepo,
        super(SeasonDetailsState());

  @override
  Stream<SeasonDetailsState> mapEventToState(SeasonDetailsEvent event) async* {
    if (event is LoadSeasonDetails) {
      yield* _loadSeasonDetails(event);
    }
  }

  Stream<SeasonDetailsState> _loadSeasonDetails(
      LoadSeasonDetails event) async* {
    yield SeasonDetailsLoading();
    try {
      final seasonDetails = await _seasonDetailsRepo.loadSeasonDetails(
          event.id, event.seasonNumber, 1);
      yield SeasonDetailsLoaded(seasonDetailsData: seasonDetails);
    } catch (error) {
      yield SeasonDetailsLoadingError(error: error);
    }
  }
}
