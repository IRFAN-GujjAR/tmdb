

import 'package:tmdb/models/details/common.dart';

class SeasonDetailsData {
  final String name;
  final String airDate;
  final String overview;
  final String posterPath;
  final List<Episode> episodes;

  SeasonDetailsData({this.name,this.airDate, this.overview, this.posterPath, this.episodes});

  factory SeasonDetailsData.fromJson(Map<String,dynamic> json){
    return SeasonDetailsData(
      name: json['name'] as String,
      airDate: formatDate(json['air_date'] as String),
      overview: json['overview'] as String,
      posterPath:json['poster_path'],
      episodes: _getEpisodes(json['episodes'])
    );
  }
}

List<Episode> _getEpisodes(List<dynamic> json) {
  if(json==null||json.isEmpty){
    return null;
  }

  List<Episode> episodes =
      json.map((episode) => Episode.fromJson(episode)).toList();

  return episodes;
}

class Episode {
  final String name;
  final String airDate;
  final String overview;
  final String stillPath;
  final int voteCount;
  final double voteAverage;

  Episode(
      {this.name,
        this.airDate,
      this.overview,
      this.stillPath,
      this.voteCount,
      this.voteAverage});

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
        name: json['name'] as String,
        airDate: formatDate(json['air_date'] as String),
        overview: json['overview'] as String,
        stillPath: json['still_path'] as String,
        voteCount: int.parse(json['vote_count'].toString()),
        voteAverage: double.parse(json['vote_average'].toString()));
  }
}
