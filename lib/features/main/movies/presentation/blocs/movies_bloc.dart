import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/core/database/app_database.dart';
import 'package:tmdb/core/error/custom_error_utl.dart';
import 'package:tmdb/core/ui/initialize_app.dart';
import 'package:tmdb/features/ads_manager/presentation/blocs/ads_manager_bloc.dart';
import 'package:tmdb/features/main/movies/domain/entities/movies_entity.dart';
import 'package:tmdb/features/main/movies/domain/use_cases/movies_use_case_load.dart';
import 'package:tmdb/features/main/movies/domain/use_cases/movies_use_case_watch.dart';

import 'movies_events.dart';
import 'movies_states.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final AdsManagerBloc _adsManagerBloc;
  final MoviesUseCaseLoad _moviesUseCase;
  final MoviesUseCaseWatch _moviesUseCaseWatch;
  late StreamSubscription _subscription;

  MoviesBloc(
    this._adsManagerBloc, {
    required MoviesUseCaseLoad moviesUseCase,
    required MoviesUseCaseWatch moviesUseCaseWatch,
  }) : _moviesUseCase = moviesUseCase,
       _moviesUseCaseWatch = moviesUseCaseWatch,
       super(MoviesStateLoading()) {
    _subscription = _moviesUseCaseWatch.call.listen((value) {
      if (value != null) {
        _onWatch(value);
      }
    });
    on<MoviesEvent>((event, emit) async {
      switch (event) {
        case MoviesEventLoad():
          await _onLoad(emit);
          break;
        case MoviesEventUpdated():
          emit(MoviesStateLoaded(movies: event.movies));
          break;
        case MoviesEventRefresh():
          await _onLoad(emit, completer: event.completer);
          break;
      }
    });
  }
  void _onWatch(MoviesTableData value) {
    add(
      MoviesEventUpdated(
        movies: MoviesEntity(
          popular: value.popular.toEntity,
          inTheatres: value.inTheatre.toEntity,
          trending: value.trending.toEntity,
          topRated: value.topRated.toEntity,
          upComing: value.upComing.toEntity,
        ),
      ),
    );
  }

  Future<void> _onLoad(
    Emitter<MoviesState> emit, {
    Completer<void>? completer,
  }) async {
    if (state is MoviesStateErrorWithoutCache) emit(MoviesStateLoading());
    try {
      await _moviesUseCase.call;
      AdsManagerBloc.increment(_adsManagerBloc);
      if (completer != null) {
        completer.complete();
      }
    } catch (error) {
      logger.e(error);
      if (completer != null) {
        completer.complete();
      }
      final errorEntity = CustomErrorUtl.getError(error);
      AdsManagerBloc.incrementOnError(_adsManagerBloc, errorEntity);
      if (state is MoviesStateLoaded) {
        final data = state as MoviesStateLoaded;
        emit(
          MoviesStateErrorWithCache(movies: data.movies, error: errorEntity),
        );
      } else
        emit(MoviesStateErrorWithoutCache(error: errorEntity));
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
