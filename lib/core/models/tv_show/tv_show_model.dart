import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/core/entities/tv_show/tv_show_entity.dart';

part 'tv_show_model.g.dart';

@JsonSerializable(ignoreUnannotated: true)
final class TvShowModel extends TvShowEntity {
  TvShowModel({
    required super.id,
    required super.name,
    required super.genreIds,
    required super.posterPath,
    required super.backdropPath,
    required super.voteAverage,
    required super.voteCount,
  });

  factory TvShowModel.fromJson(Map<String, dynamic> json) =>
      _$TvShowModelFromJson(json);

  Map<String, dynamic> toJson() => _$TvShowModelToJson(this);
}
