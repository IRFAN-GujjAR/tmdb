import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/bloc/home/tv_shows/details/tv_show_details_events.dart';
import 'package:tmdb/bloc/home/tv_shows/details/tv_show_details_states.dart';
import 'package:tmdb/repositories/home/tv_shows/tv_show_details/tv_show_details_repo.dart';

class TvShowDetailsBloc extends Bloc<TvShowDetailsEvent, TvShowDetailsState> {
  final TvShowDetailsRepo _tvShowDetailsRepo;

  TvShowDetailsBloc({@required TvShowDetailsRepo tvShowDetailsRepo})
      : _tvShowDetailsRepo = tvShowDetailsRepo,
        super(TvShowDetailsState());

  @override
  Stream<TvShowDetailsState> mapEventToState(TvShowDetailsEvent event) async* {
    if (event is LoadTvShowDetails) {
      yield* _loadTvShowDetails(event);
    }
  }

  Stream<TvShowDetailsState> _loadTvShowDetails(
      LoadTvShowDetails event) async* {
    yield TvShowDetailsLoading();
    try {
      final tvShowDetails =
          await _tvShowDetailsRepo.loadTvShowDetails(event.tvId);
      yield TvShowDetailsLoaded(tvShowDetails: tvShowDetails);
    } catch (error) {
      yield TvShowDetailsLoadingError(error: error);
    }
  }
}
