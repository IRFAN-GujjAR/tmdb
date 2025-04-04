import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tmdb/core/entities/error/custom_error_entity.dart';
import 'package:tmdb/core/entities/search/searches_entity.dart';
import 'package:tmdb/core/error/custom_error_utl.dart';
import 'package:tmdb/core/ui/initialize_app.dart';
import 'package:tmdb/features/ads_manager/presentation/blocs/ads_manager_bloc.dart';
import 'package:tmdb/features/main/search/search/domain/use_cases/params/search_params.dart';
import 'package:tmdb/features/main/search/search/domain/use_cases/search_use_case.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final AdsManagerBloc _adsManagerBloc;
  final SearchUseCase _useCase;

  SearchBloc(this._adsManagerBloc, this._useCase)
    : super(SearchStateInitial()) {
    on<SearchEvent>((event, emit) async {
      switch (event) {
        case SearchEventLoad():
          await _onLoad(event, emit);
          break;
      }
    });
  }

  Future<void> _onLoad(SearchEventLoad event, Emitter<SearchState> emit) async {
    emit(SearchStateLoading());
    try {
      final searchesEntity = await _useCase.call(event.params);
      AdsManagerBloc.increment(_adsManagerBloc);
      if (searchesEntity.searches.isEmpty)
        emit(const SearchStateNoItemsFound());
      else
        emit(SearchStateLoaded(searchesEntity: searchesEntity));
    } catch (e) {
      logger.e(e);
      final error = CustomErrorUtl.getError(e);
      AdsManagerBloc.incrementOnError(_adsManagerBloc, error);
      emit(SearchStateError(error: error));
    }
  }
}
