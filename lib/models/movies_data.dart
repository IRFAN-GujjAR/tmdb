class MoviesData {
  final int id;
  final String title;
  final List<int> genreIds;
  final String posterPath;
  final String backdropPath;
  final int voteCount;
  final double voteAverage;
  final String releaseDate;
  final double rating;

  MoviesData(
      {this.id,
      this.title,
      this.genreIds,
      this.posterPath,
      this.backdropPath,
      this.voteCount,
      this.voteAverage,
      this.releaseDate,
      this.rating});

      factory MoviesData.fromJson(Map<String,dynamic> json){
        return MoviesData(
          id: json['id'] as int,
          title: json['title'] as String,
          genreIds: json['genre_ids'].cast<int>() ,
          posterPath: json['poster_path'] as String,
          backdropPath: json['backdrop_path'] as String,
          voteCount: int.parse(json['vote_count'].toString()),
          voteAverage: double.parse(json['vote_average'].toString()),
          releaseDate: json['release_date'] as String,
          rating: json['rating']
        );
      }
}
