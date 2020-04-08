

import 'package:tmdb/models/tv_Shows_data.dart';

class TvShowsList{
  final int pageNumber;
  final int totalPages;
  final List<TvShowsData> tvShows;

  TvShowsList({this.pageNumber,this.totalPages,this.tvShows});

}