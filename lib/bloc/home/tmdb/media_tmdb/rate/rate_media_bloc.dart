import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/bloc/home/tmdb/media_tmdb/rate/rate_media_events.dart';
import 'package:tmdb/bloc/home/tmdb/media_tmdb/rate/rate_media_states.dart';
import 'package:tmdb/models/user_info_model.dart';
import 'package:tmdb/repositories/home/tmdb/media_tmdb/rate_media_repo.dart';

class RateMediaBloc extends Bloc<RateMediaEvent, RateMediaState> {
  final RateMediaRepo _rateMediaRepo;

  RateMediaBloc({@required RateMediaRepo rateMediaRepo})
      : _rateMediaRepo = rateMediaRepo,
        super(RateMediaState());

  @override
  Stream<RateMediaState> mapEventToState(RateMediaEvent event) async* {
    if (event is AddRatingRateMedia) {
      yield* _rateOrUnRate(
          user: event.user, mediaId: event.mediaId, rating: event.rating);
    } else if (event is DeleteRatingRateMedia) {
      yield* _rateOrUnRate(user: event.user, mediaId: event.mediaId);
    }
  }

  Stream<RateMediaState> _rateOrUnRate(
      {@required UserInfoModel user,
      @required int mediaId,
      int rating}) async* {
    yield RateMediaLoading();
    try {
      if (rating != null)
        await _rateMediaRepo.rateMedia(
            user: user, rating: rating, mediaId: mediaId);
      else
        await _rateMediaRepo.deleteMediaRating(user: user, mediaId: mediaId);
      if (rating != null)
        yield RateMediaRated(mediaId: mediaId);
      else
        yield RateMediaUnRated(mediaId: mediaId);
    } catch (error) {}
  }
}
