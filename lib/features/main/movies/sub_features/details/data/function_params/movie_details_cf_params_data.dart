import 'package:json_annotation/json_annotation.dart';

part 'movie_details_cf_params_data.g.dart';

@JsonSerializable(createFactory: false)
final class MovieDetailsCFParamsData {
  @JsonKey(name: 'movie_id')
  final int movieId;

  const MovieDetailsCFParamsData({required this.movieId});

  Map<String, dynamic> toJson() => _$MovieDetailsCFParamsDataToJson(this);
}
