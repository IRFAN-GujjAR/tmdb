class TvShowsData {
  final int id;
  final String name;
  final List<int> genreIds;
  final String posterPath;
  final String backdropPath;
  final double voteAverage;
  final int voteCount;
  final double rating;

  TvShowsData(
      {this.id,
      this.name,
      this.genreIds,
      this.posterPath,
      this.backdropPath,
      this.voteAverage,
      this.voteCount,
      this.rating});

  factory TvShowsData.fromJson(Map<String, dynamic> json) {
    return TvShowsData(
        id: json['id'] as int,
        name: json['name'] as String,
        genreIds: json['genre_ids'].cast<int>(),
        posterPath: json['poster_path'] as String,
        backdropPath: json['backdrop_path'] as String,
        voteCount: int.parse(json['vote_count'].toString()),
        voteAverage: double.parse(json['vote_average'].toString()),
        rating: json['rating']
    );
  }
}
