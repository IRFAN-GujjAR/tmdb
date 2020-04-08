
import 'movies_data.dart';

class MoviesList{

  final int pageNumber;
  final int totalPages;
  final List<MoviesData> movies;

  MoviesList({this.pageNumber,this.totalPages,this.movies});
}