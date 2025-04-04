import 'package:json_annotation/json_annotation.dart';

enum TvShowsListCFCategory {
  @JsonValue('airing_today')
  airingToday,
  trending,
  @JsonValue('top_rated')
  topRated,
  popular,
  recommended,
  similar,
}
