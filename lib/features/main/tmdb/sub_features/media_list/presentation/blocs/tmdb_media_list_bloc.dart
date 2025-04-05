import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/features/ads_manager/presentation/blocs/ads_manager_bloc.dart';
import 'package:tmdb/features/main/tmdb/sub_features/media_list/domain/usecases/tmdb_media_list_usecase.dart';
import 'package:tmdb/features/main/tmdb/sub_features/media_list/presentation/blocs/tmdb_media_list_event.dart';
import 'package:tmdb/features/main/tmdb/sub_features/media_list/presentation/blocs/tmdb_media_list_state.dart';

import '../../../../../../../core/error/custom_error_utl.dart';
import '../../../../../../../core/ui/initialize_app.dart';

final class TMDbMediaListBloc
    extends Bloc<TMDbMediaListEvent, TMDbMediaListState> {
  final AdsManagerBloc _adsManagerBloc;
  final TMDbMediaListUseCase _useCase;

  TMDbMediaListBloc(this._adsManagerBloc, this._useCase)
    : super(TMDbMediaListStateInitial()) {
    on<TMDbMediaListEvent>((event, emit) async {
      switch (event) {
        case TMDbMediaListEventLoad():
          await _onLoad(event, emit);
          break;
      }
    });
  }

  Future<void> _onLoad(
    TMDbMediaListEventLoad event,
    Emitter<TMDbMediaListState> emit,
  ) async {
    emit(TMDbMediaListStateLoading());
    try {
      logger.d(event.cfParamsData.movieList);
      final tMDBMediaList = await _useCase.call(event.cfParamsData);
      AdsManagerBloc.increment(_adsManagerBloc);
      if (tMDBMediaList.isMovies || tMDBMediaList.isTvShows)
        emit(TMDbMediaListStateLoaded(tMDBMediaList));
      else
        emit(TMDbMediaListStateEmpty());
    } catch (e) {
      logger.e(e);
      final error = CustomErrorUtl.getError(e);
      AdsManagerBloc.incrementOnError(_adsManagerBloc, error);
      emit(TMDbMediaListStateError(error));
    }
  }
}
