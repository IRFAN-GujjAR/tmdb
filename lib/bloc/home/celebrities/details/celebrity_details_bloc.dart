import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/bloc/home/celebrities/details/celebrity_details_events.dart';
import 'package:tmdb/bloc/home/celebrities/details/celebrity_details_states.dart';
import 'package:tmdb/repositories/home/celebrities/celebrities_details/celebrities_details_repo.dart';

class CelebrityDetailsBloc
    extends Bloc<CelebrityDetailsEvent, CelebrityDetailsState> {
  final CelebritiesDetailsRepo _celebritiesDetailsRepo;

  CelebrityDetailsBloc(
      {@required CelebritiesDetailsRepo celebritiesDetailsRepo})
      : _celebritiesDetailsRepo = celebritiesDetailsRepo,
        super(CelebrityDetailsState());

  @override
  Stream<CelebrityDetailsState> mapEventToState(
      CelebrityDetailsEvent event) async* {
    if (event is LoadCelebrityDetails) {
      yield* _loadCelebritiesDetails(event);
    }
  }

  Stream<CelebrityDetailsState> _loadCelebritiesDetails(
      LoadCelebrityDetails event) async* {
    yield CelebrityDetailsLoading();
    try {
      final celebrityDetails =
          await _celebritiesDetailsRepo.loadCelebritiesDetails(event.id);
      yield CelebrityDetailsLoaded(celebritiesDetails: celebrityDetails);
    } catch (error) {
      yield CelebrityDetailsLoadingError(error: error);
    }
  }
}
