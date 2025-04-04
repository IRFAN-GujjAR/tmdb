import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/core/models/movie/movie_model.dart';

import '../../../../../../../core/api/utils/json_keys_names.dart';

part 'movie_credits_model.g.dart';

@JsonSerializable(createToJson: false, ignoreUnannotated: true)
final class MovieCreditsModel extends Equatable {
  @JsonKey(name: JsonKeysNames.cast)
  final List<MovieModel> cast;
  @JsonKey(name: JsonKeysNames.crew)
  final List<MovieModel> crew;

  MovieCreditsModel({required this.cast, required this.crew});

  factory MovieCreditsModel.fromJson(Map<String, dynamic> json) =>
      _$MovieCreditsModelFromJson(json);

  @override
  List<Object?> get props => [cast, crew];
}
