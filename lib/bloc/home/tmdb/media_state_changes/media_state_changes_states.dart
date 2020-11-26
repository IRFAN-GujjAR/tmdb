import 'package:flutter/material.dart';

class MediaStateChangesState {
  const MediaStateChangesState();
}

class MediaStateChangesMovieChanged extends MediaStateChangesState {
  final int movieId;

  const MediaStateChangesMovieChanged({@required this.movieId});
}

class MediaStateChangesTvShowChanged extends MediaStateChangesState {
  final int tvId;

  const MediaStateChangesTvShowChanged({@required this.tvId});
}
