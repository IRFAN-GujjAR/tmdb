import 'package:tmdb/models/tv_Shows_data.dart';
import 'package:tmdb/models/tv_shows_list.dart';

import 'common.dart';

class TvShowDetailsData {
  final String backdropPath;
  final String posterPath;
  final String name;
  final double voteAverage;
  final int voteCount;
  final List<Genre> genres;
  final String overview;
  final List<Season> seasons;
  final Credits credits;
  final List<Image> images;
  final List<Video> videos;
  final List<Creator> createBy;
  final String firstAirDate;
  final String language;
  final List<String> countryOrigin;
  final List<Network> networks;
  final List<ProductionCompany> productionCompanies;
  final TvShowsList recommendedTvShows;
  final TvShowsList similarTvShows;

  TvShowDetailsData(
      {this.backdropPath,
      this.posterPath,
      this.name,
      this.voteAverage,
      this.voteCount,
      this.genres,
      this.overview,
      this.seasons,
      this.credits,
      this.images,
      this.videos,
      this.createBy,
      this.firstAirDate,
      this.language,
      this.countryOrigin,
      this.networks,
      this.productionCompanies,
      this.recommendedTvShows,
      this.similarTvShows});

  factory TvShowDetailsData.fromJson(Map<String, dynamic> json) {
    return TvShowDetailsData(
        backdropPath: json['backdrop_path'] as String,
        posterPath: json['poster_path'] as String,
        name: json['name'],
        voteAverage: json['vote_average'] as double,
        voteCount: json['vote_count'] as int,
        genres: getGenres(json['genres']),
        overview: json['overview'] as String,
        seasons: _getSeasons(json['seasons']),
        credits: Credits.fromJson(json['credits']),
        images: getImages(json['images']),
        videos: getVideos(json['videos']),
        createBy: _getCreatedBy(json['created_by']),
        firstAirDate: formatDate(json['first_air_date'] as String),
        language: formatLanguage(json['original_language'] as String),
        countryOrigin: json['origin_country'].cast<String>(),
        networks: _getNetworks(json['networks']),
        productionCompanies:
            getProductionCompanies(json['production_companies']),
        recommendedTvShows: _getSimilarOrRecommendedTvShows(json['recommendations']),
        similarTvShows: _getSimilarOrRecommendedTvShows(json['similar']));
  }
}

List<Season> _getSeasons(List<dynamic> json) {

  if(json==null||json.isEmpty){
    return null;
  }
  List<Season> seasons =
      json.map((season) => Season.fromJson(season)).toList();

  return seasons;
}

class Season {
  final int id;
  final int seasonNumber;
  final String name;
  final String posterPath;

  Season({this.id, this.seasonNumber, this.name, this.posterPath});

  factory Season.fromJson(Map<String, dynamic> json) {
    return Season(
      id: json['id'] as int,
      seasonNumber: json['season_number'] as int,
      name: json['name'] as String,
      posterPath: json['poster_path'] as String,
    );
  }
}

List<Creator> _getCreatedBy(List<dynamic> json) {

  if(json==null||json.isEmpty){
    return null;
  }

  List<Creator> creators =
      json.map((creator) => Creator.fromJson(creator)).toList();

  return creators;
}

class Creator {
  final int id;
  final String name;

  Creator({this.id, this.name});

  factory Creator.fromJson(Map<String, dynamic> json) {
    return Creator(id: json['id'] as int, name: json['name'] as String);
  }
}

List<Network> _getNetworks(List<dynamic> json) {
  if(json==null||json.isEmpty){
    return null;
  }

  List<Network> networks =
      json.map((network) => Network.fromJson(network)).toList();

  return networks;
}

class Network {
  final String name;

  Network({this.name});

  factory Network.fromJson(Map<String, dynamic> json) {
    return Network(name: json['name'] as String);
  }
}

TvShowsList _getSimilarOrRecommendedTvShows(Map<String, dynamic> json) {
  if(json==null||json.isEmpty){
    return null;
  }

  int totalPages=json['total_pages'] as int;
  int pageNumber=json['page'] as int;
  var tvShowsList = json['results'] as List;
  List<TvShowsData> tvShows = tvShowsList
      .map((tvShow) => TvShowsData.fromJson(tvShow))
      .toList();

  return TvShowsList(pageNumber: pageNumber,totalPages: totalPages,tvShows: tvShows);
}
