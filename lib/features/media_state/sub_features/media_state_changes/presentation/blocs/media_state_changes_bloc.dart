import 'package:flutter_bloc/flutter_bloc.dart';

part 'media_state_changes_events.dart';
part 'media_state_changes_states.dart';

class MediaStateChangesBloc
    extends Bloc<MediaStateChangesEvent, MediaStateChangesState> {
  MediaStateChangesBloc() : super(MediaStateChangesStateInitial()) {
    on<NotifyMovieMediaStateChanges>((event, emit) =>
        emit(MediaStateChangesMovieChanged(movieId: event.movieId)));
    on<NotifyTvShowMediaStateChanges>((event, emit) =>
        emit(MediaStateChangesTvShowChanged(tvId: event.tvId)));
  }
}
