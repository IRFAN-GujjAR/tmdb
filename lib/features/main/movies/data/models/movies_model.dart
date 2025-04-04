import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/core/models/movie/movies_list_model.dart';

part 'movies_model.g.dart';

@JsonSerializable(createToJson: false, ignoreUnannotated: true)
final class MoviesModel extends Equatable {
  @JsonKey(name: 'popular')
  final MoviesListModel popular;
  @JsonKey(name: 'in_theatres')
  final MoviesListModel inTheatres;
  @JsonKey(name: 'trending')
  final MoviesListModel trending;
  @JsonKey(name: 'top_rated')
  final MoviesListModel topRated;
  @JsonKey(name: 'upcoming')
  final MoviesListModel upComing;

  const MoviesModel({
    required this.popular,
    required this.inTheatres,
    required this.trending,
    required this.topRated,
    required this.upComing,
  });

  factory MoviesModel.fromJson(Map<String, dynamic> json) =>
      _$MoviesModelFromJson(json);

  @override
  List<Object?> get props => [
    popular,
    inTheatres,
    trending,
    topRated,
    upComing,
  ];
}
