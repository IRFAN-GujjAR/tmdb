import 'package:json_annotation/json_annotation.dart';

enum MoviesListCFCategory {
  popular,
  @JsonValue('in_theatres')
  inTheatres,
  @JsonValue('trending')
  trending,
  @JsonValue('top_rated')
  topRated,
  @JsonValue('upcoming')
  upComing,
  recommended,
  similar,
}
