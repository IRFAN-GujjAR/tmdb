
import '../movies_data.dart';

class CollectionDetailsData {
  final String name;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final List<MoviesData> movies;

  CollectionDetailsData(
      {this.name,
      this.overview,
      this.posterPath,
      this.backdropPath,
      this.movies});

  factory CollectionDetailsData.fromJson(Map<String, dynamic> json) {
    return CollectionDetailsData(
        name: json['name'] as String,
        overview: json['overview'] as String,
        posterPath: json['poster_path'] as String,
        backdropPath: json['backdrop_path'] as String,
        movies: _getMovies(json['parts']));
  }
}

List<MoviesData> _getMovies(List<dynamic> json) {
  if (json == null || json.isEmpty) {
    return null;
  }

  List<MoviesData> movies =
      json.map((movie) => MoviesData.fromJson(movie)).toList();

  List<MoviesData> deleteMovies;

  movies.forEach((movie){
    if(movie.posterPath==null||movie.backdropPath==null){
      deleteMovies==null?deleteMovies=[movie]:deleteMovies.add(movie);
    }
  });

  if(deleteMovies!=null){
    deleteMovies.forEach((movie){
      movies.remove(movie);
    });
  }

  return movies;
}
