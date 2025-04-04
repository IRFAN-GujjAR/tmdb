part of 'media_state_changes_bloc.dart';

class MediaStateChangesEvent {
  const MediaStateChangesEvent();
}

class NotifyMovieMediaStateChanges extends MediaStateChangesEvent {
  final int movieId;

  const NotifyMovieMediaStateChanges({required this.movieId});
}

class NotifyTvShowMediaStateChanges extends MediaStateChangesEvent {
  final int tvId;

  const NotifyTvShowMediaStateChanges({required this.tvId});
}
