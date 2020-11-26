import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/bloc/home/tmdb/media_tmdb/watch_list/watch_list_media_events.dart';
import 'package:tmdb/bloc/home/tmdb/media_tmdb/watch_list/watch_list_media_states.dart';
import 'package:tmdb/models/user_info_model.dart';
import 'package:tmdb/repositories/home/tmdb/media_tmdb/watch_list_media_repo.dart';

class WatchListMediaBloc
    extends Bloc<WatchListMediaEvent, WatchListMediaState> {
  final WatchListMediaRepo _watchListMediaRepo;

  WatchListMediaBloc({@required WatchListMediaRepo watchListMediaRepo})
      : _watchListMediaRepo = watchListMediaRepo,
        super(WatchListMediaState());

  @override
  Stream<WatchListMediaState> mapEventToState(
      WatchListMediaEvent event) async* {
    if (event is AddWatchListMedia) {
      yield* _addOrRemove(
          user: event.user, mediaId: event.mediaId, add: event.add);
    } else if (event is RemoveWatchListMedia) {
      yield* _addOrRemove(
          user: event.user, mediaId: event.mediaId, add: event.add);
    }
  }

  Stream<WatchListMediaState> _addOrRemove(
      {@required UserInfoModel user,
      @required int mediaId,
      @required bool add}) async* {
    yield WatchListMediaLoading();
    try {
      await _watchListMediaRepo.addOrRemoveFromWatchList(
          user: user, mediaId: mediaId, add: add);
      if (add)
        yield WatchListMediaAdded(mediaId: mediaId);
      else
        yield WatchListMediaRemoved(mediaId: mediaId);
    } catch (error) {
      yield WatchListMediaError(error: error);
    }
  }
}
