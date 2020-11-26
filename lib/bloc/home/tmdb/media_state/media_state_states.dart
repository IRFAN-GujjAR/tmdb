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

class MediaStatError extends MediaStateState {
  final dynamic error;

  const MediaStatError({@required this.error});
}
