import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tmdb/core/error/custom_error_utl.dart';
import 'package:tmdb/core/ui/initialize_app.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/favourite/domain/use_cases/favorite_media_use_case.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/favourite/domain/use_cases/params/favorite_media_params.dart';

part 'favorite_media_event.dart';
part 'favorite_media_state.dart';

class FavoriteMediaBloc extends Bloc<FavoriteMediaEvent, FavoriteMediaState> {
  final FavoriteMediaUseCase _useCase;

  FavoriteMediaBloc(this._useCase) : super(FavoriteMediaStateInitial()) {
    on<FavoriteMediaEvent>((event, emit) async {
      await _onEvent(event, emit);
    });
  }

  Future<void> _onEvent(
    FavoriteMediaEvent event,
    Emitter<FavoriteMediaState> emit,
  ) async {
    if (event.params.favoriteMedia.set)
      emit(FavoriteMediaStateMarking());
    else
      emit(FavoriteMediaStateUnMarking());
    try {
      final result = await _useCase.call(event.params);
      switch (result.statusCode) {
        case 1:
        case 12:
        case 13:
          if (event.params.favoriteMedia.set)
            emit(FavoriteMediaStateMarked());
          else
            emit(FavoriteMediaStateUnMarked());
          break;
        default:
          emit(FavoriteMediaStateError(result.statusMessage!));
      }
    } catch (e) {
      logger.e(e);
      emit(
        FavoriteMediaStateError(CustomErrorUtl.getError(e).error.errorMessage),
      );
    }
  }
}
