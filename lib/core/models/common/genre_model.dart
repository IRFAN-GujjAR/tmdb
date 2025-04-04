import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/core/entities/common/genre_entity.dart';

part 'genre_model.g.dart';

@JsonSerializable(createToJson: false, ignoreUnannotated: true)
final class GenreModel extends GenreEntity {
  GenreModel({required super.name});

  factory GenreModel.fromJson(Map<String, dynamic> json) =>
      _$GenreModelFromJson(json);
}
