import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/core/entities/error/custom_error_entity.dart';
import 'package:tmdb/core/error/custom_error_utl.dart';
import 'package:tmdb/core/ui/initialize_app.dart';
import 'package:tmdb/features/ads_manager/presentation/blocs/ads_manager_bloc.dart';
import 'package:tmdb/features/main/search/details/domain/use_cases/search_details_use_case.dart';

import '../../domain/entities/search_details_entity.dart';

part 'search_details_event.dart';
part 'search_details_state.dart';

final class SearchDetailsBloc
    extends Bloc<SearchDetailsEvent, SearchDetailsState> {
  final AdsManagerBloc _adsManagerBloc;
  final SearchDetailsUseCase _useCase;

  SearchDetailsBloc(this._adsManagerBloc, this._useCase)
    : super(SearchDetailsStateInitial()) {
    on<SearchDetailsEvent>((event, emit) async {
      switch (event) {
        case SearchDetailsEventLoad():
          await _onLoad(event, emit);
          break;
      }
    });
  }

  Future<void> _onLoad(
    SearchDetailsEventLoad event,
    Emitter<SearchDetailsState> emit,
  ) async {
    emit(SearchDetailsStateLoading());
    try {
      final searchDetails = await _useCase.call(event.query);
      AdsManagerBloc.increment(_adsManagerBloc);
      emit(SearchDetailsStateLoaded(searchDetails: searchDetails));
    } catch (e) {
      logger.e(e);
      final error = CustomErrorUtl.getError(e);
      AdsManagerBloc.incrementOnError(_adsManagerBloc, error);
      emit(SearchDetailsStateError(error: error));
    }
  }
}
