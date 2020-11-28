import 'package:flutter/material.dart';
import 'package:tmdb/models/media_state_model.dart';

class MediaStateState {
  const MediaStateState();
}

class MediaStateLoading extends MediaStateState {}

class MediaStateLoaded extends MediaStateState {
  final MediaStateModel mediaState;

  const MediaStateLoaded({@required this.mediaState});
}

class MediaStateError extends MediaStateState {
  final dynamic error;

  const MediaStateError({@required this.error});
}
