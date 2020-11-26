import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

enum MoviesCategories {
  Popular,
  InTheatres,
  Trending,
  TopRated,
  Upcoming,
  DetailsRecommended,
  DetailsSimilar
}

enum TvShowsCategories {
  AiringToday,
  Trending,
  TopRated,
  Popular,
  DetailsRecommended,
  DetailsSimilar
}

enum CelebrityCategories { Popular, Trending }

Client getHttpClient(BuildContext context) {
  return Provider.of<Client>(context, listen: false);
}
