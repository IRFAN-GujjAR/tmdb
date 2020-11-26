import 'package:tmdb/models/tv_Shows_data.dart';

class TvShowsList {
  final int pageNumber;
  final int totalPages;
  final List<TvShowsData> tvShows;

  TvShowsList({this.pageNumber, this.totalPages, this.tvShows});

  factory TvShowsList.fromJson(Map<String, dynamic> json) => TvShowsList(
      pageNumber: json['page'],
      totalPages: json['total_pages'],
      tvShows: json['results']
          .map<TvShowsData>((json) => TvShowsData.fromJson(json))
          .toList());
}
