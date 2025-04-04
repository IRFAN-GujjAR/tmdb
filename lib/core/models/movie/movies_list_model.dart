import 'package:drift/drift.dart' as drift;
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/core/api/utils/json_keys_names.dart';
import 'package:tmdb/core/entities/movie/movies_list_entity.dart';
import 'package:tmdb/core/models/movie/movie_model.dart';

part 'movies_list_model.g.dart';

@JsonSerializable(explicitToJson: true, ignoreUnannotated: true)
final class MoviesListModel extends Equatable {
  @JsonKey(name: JsonKeysNames.pageNo)
  final int pageNo;
  @JsonKey(name: JsonKeysNames.totalPages)
  final int totalPages;
  @JsonKey(name: JsonKeysNames.results)
  final List<MovieModel> movies;

  const MoviesListModel({
    required this.pageNo,
    required this.totalPages,
    required this.movies,
  });

  factory MoviesListModel.fromJson(Map<String, dynamic> json) =>
      _$MoviesListModelFromJson(json);

  Map<String, dynamic> toJson() => _$MoviesListModelToJson(this);

  MoviesListEntity get toEntity =>
      MoviesListEntity(pageNo: pageNo, totalPages: totalPages, movies: movies);

  static drift.JsonTypeConverter2<MoviesListModel, drift.Uint8List, Object?>
  binaryConverter = drift.TypeConverter.jsonb(
    fromJson:
        (value) => MoviesListModel.fromJson(value as Map<String, Object?>),
    toJson: (value) => value.toJson(),
  );

  @override
  List<Object?> get props => [pageNo, totalPages, movies];
}
