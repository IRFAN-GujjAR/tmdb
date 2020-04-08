

import '../movies_data.dart';
import '../movies_list.dart';
import 'common.dart';

class MovieDetailsData {
  final String backdropPath;
  final String posterPath;
  final String title;
  final double voteAverage;
  final int voteCount;
  final List<Genre> genres;
  final String overview;
  final Collection collection;
  final Credits credits;
  final List<Image> images;
  final List<Video> videos;
  final String releaseDate;
  final String language;
  final String budget;
  final String revenue;
  final List<ProductionCompany> productionCompanies;
  final MoviesList recommendedMovies;
  final MoviesList similarMovies;

  MovieDetailsData(
      {this.backdropPath,
      this.posterPath,
      this.title,
      this.genres,
      this.overview,
      this.collection,
      this.credits,
      this.images,
      this.videos,
      this.voteAverage,
      this.voteCount,
      this.releaseDate,
      this.language,
      this.budget,
      this.revenue,
      this.productionCompanies,
      this.recommendedMovies,
      this.similarMovies});

  factory MovieDetailsData.fromJson(Map<String, dynamic> json) {
    return MovieDetailsData(
        backdropPath: json['backdrop_path'] as String,
        posterPath: json['poster_path'] as String,
        title: json['title'] as String,
        voteAverage: json['vote_average'] as double,
        voteCount: json['vote_count'] as int,
        genres: getGenres(json['genres']),
        overview: json['overview'] as String,
        collection: Collection.fromJson(json['belongs_to_collection']),
        credits: Credits.fromJson(json['credits']),
        images: getImages(json['images']),
        videos: getVideos(json['videos']),
        releaseDate: formatDate(json['release_date'] as String),
        language: formatLanguage(json['original_language'] as String),
        budget: _formatBudgetOrRevenue(json['budget'].toString()),
        revenue: _formatBudgetOrRevenue(json['revenue'].toString()),
        productionCompanies:
            getProductionCompanies(json['production_companies']),
        recommendedMovies: _getSimilarOrRecommendedMovies(json['recommendations']),
        similarMovies: _getSimilarOrRecommendedMovies(json['similar']));
  }
}

String _formatBudgetOrRevenue(String value) {
  if (value != '0') {
    double digitValue = double.parse(value);

    bool isMillion = false;

    if (value.length > 6) {
      isMillion = true;
      digitValue = digitValue / 1000000;
    }

    String formattedValue = digitValue.toString();

    var parts = formattedValue.split('.');
    String secondValue = parts[1];
    for (int i = 0; i < secondValue.length; i++) {
      if (secondValue.length > 2) {
        secondValue =
            (double.parse(secondValue) / 10).roundToDouble().toString();
      }
    }
    formattedValue = parts[0] + '.' + secondValue;
    while (formattedValue.endsWith('0') || formattedValue.endsWith('.')) {
      formattedValue = formattedValue.substring(0, formattedValue.length - 1);
    }

    if (isMillion) {
      formattedValue = formattedValue + ' Million';
    }

    return '\$' + formattedValue;
  } else {
    return value;
  }
}

MoviesList _getSimilarOrRecommendedMovies(Map<String, dynamic> json) {
  if (json == null || json.isEmpty) {
    return null;
  }

  int pageNumber = json['page'] as int;
  int totalPages = json['total_pages'] as int;
  var moviesList = json['results'] as List;
  List<MoviesData> movies =
      moviesList.map((movie) => MoviesData.fromJson(movie)).toList();

  return MoviesList(
      pageNumber: pageNumber,
      totalPages: totalPages,
      movies: movies);
}


class Collection {
  final int id;
  final String name;
  final String posterPath;
  final String backdropPath;

  Collection({this.id, this.name, this.posterPath, this.backdropPath});

  factory Collection.fromJson(Map<String, dynamic> json) {
    return json == null
        ? null
        : Collection(
            id: json['id'] as int,
            name: json['name'] as String,
            posterPath: json['poster_path'] as String,
            backdropPath: json['backdrop_path'] as String);
  }
}
