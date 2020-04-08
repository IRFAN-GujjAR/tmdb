
import '../movies_data.dart';
import '../tv_Shows_data.dart';
import 'common.dart';

class CelebritiesDetailsData {
  final String name;
  final String department;
  final String birthday;
  final String deathDay;
  final String biography;
  final String birthPlace;
  final String profilePath;
  final MovieCredits movieCredits;
  final TvCredits tvCredits;

  CelebritiesDetailsData(
      {this.name,
        this.department,
      this.birthday,
      this.deathDay,
      this.biography,
      this.birthPlace,
      this.profilePath,
      this.movieCredits,
      this.tvCredits});

  factory CelebritiesDetailsData.fromJson(Map<String, dynamic> json) {
    return CelebritiesDetailsData(
        name: json['name'] as String,
        department: json['known_for_department'] as String,
        birthday:formatDate(json['birthday'] as String),
        deathDay:formatDate(json['deathday'] as String),
        biography: json['biography'] as String,
        birthPlace: json['place_of_birth'] as String,
        profilePath: json['profile_path'] as String,
        movieCredits: MovieCredits.fromJson(json['movie_credits']),
        tvCredits: TvCredits.fromJson(json['tv_credits']));
  }
}

class MovieCredits {
  final List<MoviesData> cast;
  final List<MoviesData> crew;

  MovieCredits({this.cast, this.crew});

  factory MovieCredits.fromJson(Map<String, dynamic> json) {
    return MovieCredits(
        cast: _getMoviesCredit(json['cast']),
        crew: _getMoviesCredit(json['crew']));
  }
}

List<MoviesData> _getMoviesCredit(List<dynamic> json) {

  if(json==null||json.isEmpty){
    return null;
  }

  return json.map((movie) => MoviesData.fromJson(movie)).toList();
}

class TvCredits {
  final List<TvShowsData> cast;
  final List<TvShowsData> crew;

  TvCredits({this.cast, this.crew});

  factory TvCredits.fromJson(Map<String, dynamic> json) {
    return TvCredits(
        cast: _getTvCredits(json['cast']), crew: _getTvCredits(json['crew']));
  }
}

List<TvShowsData> _getTvCredits(List<dynamic> json) {

  if(json==null||json.isEmpty){
    return null;
  }

  return json.map((movie) => TvShowsData.fromJson(movie)).toList();
}
