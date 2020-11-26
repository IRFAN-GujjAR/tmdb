import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/bloc/home/tmdb/media_state_changes/media_state_changes_events.dart';
import 'package:tmdb/bloc/home/tmdb/media_state_changes/media_state_changes_states.dart';

class MediaStateChangesBloc
    extends Bloc<MediaStateChangesEvent, MediaStateChangesState> {
  MediaStateChangesBloc() : super(MediaStateChangesState());

  @override
  Stream<MediaStateChangesState> mapEventToState(
      MediaStateChangesEvent event) async* {
    if (event is NotifyMovieMediaStateChanges) {
      yield MediaStateChangesMovieChanged(movieId: event.movieId);
    } else if (event is NotifyTvShowMediaStateChanges) {
      yield MediaStateChangesTvShowChanged(tvId: event.tvId);
    }
  }
}
