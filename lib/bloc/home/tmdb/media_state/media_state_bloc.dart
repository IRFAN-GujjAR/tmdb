import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/bloc/home/tmdb/media_state/media_state_events.dart';
import 'package:tmdb/bloc/home/tmdb/media_state/media_state_states.dart';
import 'package:tmdb/repositories/home/tmdb/media_state/media_state_repo.dart';

class MediaStateBloc extends Bloc<MediaStateEvent, MediaStateState> {
  final MediaStateRepo _mediaStateRepo;

  MediaStateBloc({@required MediaStateRepo mediaStateRepo})
      : _mediaStateRepo = mediaStateRepo,
        super(MediaStateState());

  @override
  Stream<MediaStateState> mapEventToState(MediaStateEvent event) async* {
    if (event is LoadMediaState) {
      yield* _loadMediaState(event);
    }
  }

  Stream<MediaStateState> _loadMediaState(LoadMediaState event) async* {
    yield MediaStateLoading();
    try {
      final mediaState = await _mediaStateRepo.checkMediaStates(event.url);
      yield MediaStateLoaded(mediaState: mediaState);
    } catch (error) {
      yield MediaStateError(error: error);
    }
  }
}
