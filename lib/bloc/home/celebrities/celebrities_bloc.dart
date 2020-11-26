import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/bloc/home/celebrities/celebrities_events.dart';
import 'package:tmdb/bloc/home/celebrities/celebrities_states.dart';
import 'package:tmdb/models/celebrities_data.dart';
import 'package:tmdb/repositories/home/celebrities/celebrities_repo.dart';

class CelebritiesBloc extends Bloc<CelebritiesEvents, CelebritiesState> {
  final CelebritiesRepo _celebritiesRepo;

  CelebritiesBloc({@required CelebritiesRepo celebritiesRepo})
      : _celebritiesRepo = celebritiesRepo,
        super(CelebritiesState());

  @override
  Stream<CelebritiesState> mapEventToState(CelebritiesEvents event) async* {
    switch (event) {
      case CelebritiesEvents.Load:
        yield* _loadCelebrities;
        break;
    }
  }

  Stream<CelebritiesState> get _loadCelebrities async* {
    yield CelebritiesLoading();
    try {
      final celebritiesLists = await _celebritiesRepo.loadCelebritiesLists;
      final firstHalfPopular = <CelebritiesData>[];
      final secondHalfPopular = <CelebritiesData>[];
      int firstHalfLength =
          (celebritiesLists[0].celebrities.length / 2).round();
      for (int i = 0; i < celebritiesLists[0].celebrities.length; i++) {
        if (i < firstHalfLength) {
          firstHalfPopular.add(celebritiesLists[0].celebrities[i]);
        } else {
          secondHalfPopular.add(celebritiesLists[0].celebrities[i]);
        }
      }
      yield CelebritiesLoaded(
          celebritiesLists: celebritiesLists,
          firstHalfPopular: firstHalfPopular,
          secondHalfPopular: secondHalfPopular);
    } catch (error) {
      yield CelebritiesLoadingError(error: error);
    }
  }
}
