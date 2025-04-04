import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/core/error/custom_error_utl.dart';
import 'package:tmdb/core/ui/initialize_app.dart';
import 'package:tmdb/features/ads_manager/presentation/blocs/ads_manager_bloc.dart';
import 'package:tmdb/features/media_state/domain/use_cases/media_state_use_case.dart';
import 'package:tmdb/features/media_state/presentation/blocs/media_state_event.dart';
import 'package:tmdb/features/media_state/presentation/blocs/media_state_state.dart';

final class MediaStateBloc extends Bloc<MediaStateEvent, MediaStateState> {
  final AdsManagerBloc _adsManagerBloc;
  final MediaStateUseCase _useCase;

  MediaStateBloc(this._adsManagerBloc, this._useCase)
    : super(MediaStateStateInitial()) {
    on<MediaStateEvent>((event, emit) async {
      switch (event) {
        case MediaStateEventLoad():
          await _onLoad(event, emit);
          break;
      }
    });
  }

  Future<void> _onLoad(
    MediaStateEventLoad event,
    Emitter<MediaStateState> emit,
  ) async {
    emit(MediaStateStateLoading());
    try {
      final mediaState = await _useCase.call(event.cfParamsData);
      AdsManagerBloc.increment(_adsManagerBloc);
      emit(MediaStateStateLoaded(mediaState: mediaState));
    } catch (e) {
      logger.d(e);
      final error = CustomErrorUtl.getError(e);
      AdsManagerBloc.incrementOnError(_adsManagerBloc, error);
      emit(MediaStateStateError(error: error));
    }
  }
}
