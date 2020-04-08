import 'package:flutter/foundation.dart';

class MovieTvShowProvider extends ChangeNotifier {
  final List<MediaTMDbData> movies = [];
  final List<MediaTMDbData> tvShows=[];

  MovieTvShowProvider();

  void addMovie(MediaTMDbData mediaTMDbData) {
    bool isMatched = false;
    for (int i = 0; i < movies.length; i++) {
      if (movies[i].id == mediaTMDbData.id) {
        isMatched = true;
        movies[i].isAddedToFavorite = mediaTMDbData.isAddedToFavorite;
        movies[i].isRated = mediaTMDbData.isRated;
        movies[i].rating = mediaTMDbData.rating;
        movies[i].isAddedToWatchList = mediaTMDbData.isAddedToWatchList;
        break;
      }
    }
    if (!isMatched) {
      movies.add(mediaTMDbData);
    }
    notifyListeners();
  }

  void addTvShow(MediaTMDbData mediaTMDbData){
    bool isMatched = false;
    for (int i = 0; i < tvShows.length; i++) {
      if (tvShows[i].id == mediaTMDbData.id) {
        isMatched = true;
        tvShows[i].isAddedToFavorite = mediaTMDbData.isAddedToFavorite;
        tvShows[i].isRated = mediaTMDbData.isRated;
        tvShows[i].rating = mediaTMDbData.rating;
        tvShows[i].isAddedToWatchList = mediaTMDbData.isAddedToWatchList;
        break;
      }
    }
    if (!isMatched) {
      tvShows.add(mediaTMDbData);
    }
    notifyListeners();
  }

  MediaTMDbData getMovieTMDbData(int id) {
      for (int i = 0; i < movies.length; i++) {
        if (movies[i].id == id) {
          return MediaTMDbData(
              id: id,
              isAddedToFavorite: movies[i].isAddedToFavorite,
              isRated: movies[i].isRated,
              rating: movies[i].rating,
              isAddedToWatchList: movies[i].isAddedToWatchList);
        }
      }
    return null;
  }

  MediaTMDbData getTvShowTMDbData(int id) {
      for (int i = 0; i < tvShows.length; i++) {
        if (tvShows[i].id == id) {
          return MediaTMDbData(
              id: id,
              isAddedToFavorite: tvShows[i].isAddedToFavorite,
              isRated: tvShows[i].isRated,
              rating: tvShows[i].rating,
              isAddedToWatchList: tvShows[i].isAddedToWatchList);
        }
      }
    return null;
  }

  void userSignedOut(){
    movies.clear();
    tvShows.clear();
    notifyListeners();
  }

}

class MediaTMDbData {
  int id;
  bool isAddedToFavorite;
  bool isRated;
  bool isAddedToWatchList;
  int rating;

  MediaTMDbData(
      {@required this.id,
      @required this.isAddedToFavorite,
      @required this.isRated,
      @required this.rating,
      @required this.isAddedToWatchList})
      : assert(id != null),
        assert(isAddedToFavorite != null),
        assert(isRated != null),
        assert(isAddedToWatchList != null),
        assert(rating != null);
}
