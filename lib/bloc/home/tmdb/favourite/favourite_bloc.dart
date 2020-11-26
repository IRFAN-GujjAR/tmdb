import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/bloc/home/tmdb/favourite/favourite_events.dart';
import 'package:tmdb/bloc/home/tmdb/favourite/favourite_states.dart';
import 'package:tmdb/repositories/home/tmdb/favourite/favourite_repo.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  final FavouriteRepo _favouriteRepo;

  FavouriteBloc({@required FavouriteRepo favouriteRepo})
      : _favouriteRepo = favouriteRepo,
        super(FavouriteState());

  @override
  Stream<FavouriteState> mapEventToState(FavouriteEvent event) async* {
    if (event is LoadFavourite) {
      yield* _loadFavourites(event);
    }
  }

  Stream<FavouriteState> _loadFavourites(LoadFavourite event) async* {
    yield FavouriteLoading();
    try {
      final favourites = await _favouriteRepo.loadFavourite(event.user);
      if (favourites.isMovies || favourites.isTvShows)
        yield FavouriteLoaded(favourites: favourites);
      else
        yield FavouriteEmpty();
    } catch (error) {
      print(error);
      yield FavouriteLoadingError(error: error);
    }
  }
}
