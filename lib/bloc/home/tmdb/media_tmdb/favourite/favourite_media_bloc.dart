import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/bloc/home/tmdb/media_tmdb/favourite/favourite_media_events.dart';
import 'package:tmdb/bloc/home/tmdb/media_tmdb/favourite/favourite_media_states.dart';
import 'package:tmdb/models/user_info_model.dart';
import 'package:tmdb/repositories/home/tmdb/media_tmdb/favourite_media_repo.dart';

class FavouriteMediaBloc
    extends Bloc<FavouriteMediaEvent, FavouriteMediaState> {
  final FavouriteMediaRepo _favouriteMediaRepo;

  FavouriteMediaBloc({@required FavouriteMediaRepo favouriteMediaRepo})
      : _favouriteMediaRepo = favouriteMediaRepo,
        super(FavouriteMediaState());

  @override
  Stream<FavouriteMediaState> mapEventToState(
      FavouriteMediaEvent event) async* {
    if (event is MarkFavouriteMedia) {
      yield* _markOrUnMarkFavourit(event.user, event.mediaId, event.mark);
    } else if (event is UnMarkFavouriteMedia) {
      yield* _markOrUnMarkFavourit(event.user, event.mediaId, event.mark);
    }
  }

  Stream<FavouriteMediaState> _markOrUnMarkFavourit(
      UserInfoModel user, int mediaId, bool mark) async* {
    yield FavouriteMediaLoading();
    try {
      await _favouriteMediaRepo.markorUnMarkFavourite(
          user: user, mediaId: mediaId, mark: mark);
      if (mark)
        yield FavouriteMediaMarked(mediaId: mediaId);
      else
        yield FavouriteMediaUnMarked(mediaId: mediaId);
    } catch (error) {
      yield FavouriteMediaError(error: error);
    }
  }
}
