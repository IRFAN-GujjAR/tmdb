import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tmdb/core/database/app_database.dart';
import 'package:tmdb/core/entities/error/custom_error_entity.dart';
import 'package:tmdb/core/entities/search/search_entity.dart';
import 'package:tmdb/core/error/custom_error_utl.dart';
import 'package:tmdb/core/ui/initialize_app.dart';
import 'package:tmdb/features/ads_manager/presentation/blocs/ads_manager_bloc.dart';
import 'package:tmdb/features/main/search/trending_search/domain/use_cases/trending_search_use_case_load.dart';
import 'package:tmdb/features/main/search/trending_search/domain/use_cases/trending_search_use_case_watch.dart';

import '../../../../../../core/entities/search/searches_entity.dart';

part 'trending_search_event.dart';
part 'trending_search_state.dart';

class TrendingSearchBloc
    extends Bloc<TrendingSearchEvent, TrendingSearchState> {
  final AdsManagerBloc _adsManagerBloc;
  final TrendingSearchUseCaseWatch _useCaseWatch;
  final TrendingSearchUseCaseLoad _useCaseLoad;
  late StreamSubscription _subscription;

  TrendingSearchBloc(
    this._adsManagerBloc,
    this._useCaseWatch,
    this._useCaseLoad,
  ) : super(const TrendingSearchStateLoading()) {
    _subscription = _useCaseWatch.call.listen((value) {
      if (value != null) {
        _onWatch(value);
      }
    });
    on<TrendingSearchEvent>((event, emit) async {
      switch (event) {
        case TrendingSearchEventLoad():
          await _onLoad(emit);
          break;
        case TrendingSearchEventUpdated():
          emit(TrendingSearchStateLoaded(trendingSearch: event.trendingSearch));
          break;
        case TrendingSearchEventRefresh():
          await _onLoad(emit, completer: event.completer);
          break;
      }
    });
  }
  void _onWatch(TrendingSearchTableData value) {
    add(
      TrendingSearchEventUpdated(
        SearchesEntity(
          searches:
              value.trendingSearch.searches
                  .map((e) => SearchEntity(searchTitle: e.searchTitle))
                  .toList(),
        ),
      ),
    );
  }

  Future<void> _onLoad(
    Emitter<TrendingSearchState> emit, {
    Completer<void>? completer,
  }) async {
    if (state is TrendingSearchStateErrorWithoutCache)
      emit(TrendingSearchStateLoading());
    try {
      await _useCaseLoad.call;
      AdsManagerBloc.increment(_adsManagerBloc);
      completer?.complete();
    } catch (e) {
      logger.e(e);
      completer?.complete();
      final error = CustomErrorUtl.getError(e);
      AdsManagerBloc.incrementOnError(_adsManagerBloc, error);
      if (state is TrendingSearchStateLoaded) {
        final data = state as TrendingSearchStateLoaded;
        emit(
          TrendingSearchStateErrorWithCache(
            trendingSearch: data.trendingSearch,
            error: error,
          ),
        );
      } else
        emit(TrendingSearchStateErrorWithoutCache(error: error));
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
