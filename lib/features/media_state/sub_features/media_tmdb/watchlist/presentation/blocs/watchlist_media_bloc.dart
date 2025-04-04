import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tmdb/core/error/custom_error_utl.dart';
import 'package:tmdb/core/ui/initialize_app.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/watchlist/domain/use_cases/params/watchlist_media_params.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/watchlist/domain/use_cases/watchlist_media_use_case.dart';

part 'watchlist_media_event.dart';
part 'watchlist_media_state.dart';

class WatchlistMediaBloc
    extends Bloc<WatchlistMediaEvent, WatchlistMediaState> {
  final WatchListMediaUseCase _useCase;

  WatchlistMediaBloc(this._useCase) : super(WatchlistMediaStateInitial()) {
    on<WatchlistMediaEvent>((event, emit) async {
      await _onEvent(event, emit);
    });
  }

  Future<void> _onEvent(
    WatchlistMediaEvent event,
    Emitter<WatchlistMediaState> emit,
  ) async {
    if (event.params.watchlistMedia.set)
      emit(WatchlistMediaStateAdding());
    else
      emit(WatchlistMediaStateAdded());
    try {
      final result = await _useCase.call(event.params);
      switch (result.statusCode) {
        case 1:
        case 12:
        case 13:
          if (event.params.watchlistMedia.set)
            emit(WatchlistMediaStateAdded());
          else
            emit(WatchlistMediaStateRemoved());
          break;
        default:
          emit(WatchlistMediaStateError(errorMsg: result.statusMessage!));
          break;
      }
    } catch (e) {
      logger.e(e);
      emit(
        WatchlistMediaStateError(
          errorMsg: CustomErrorUtl.getError(e).error.errorMessage,
        ),
      );
    }
  }
}
