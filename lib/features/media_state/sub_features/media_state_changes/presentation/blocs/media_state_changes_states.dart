part of 'media_state_changes_bloc.dart';

sealed class MediaStateChangesState {
  const MediaStateChangesState();
}

final class MediaStateChangesStateInitial extends MediaStateChangesState {
  const MediaStateChangesStateInitial();
}

final class MediaStateChangesMovieChanged extends MediaStateChangesState {
  final int movieId;

  const MediaStateChangesMovieChanged({required this.movieId});
}

final class MediaStateChangesTvShowChanged extends MediaStateChangesState {
  final int tvId;

  const MediaStateChangesTvShowChanged({required this.tvId});
}
