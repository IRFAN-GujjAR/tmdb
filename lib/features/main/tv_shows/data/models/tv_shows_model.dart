import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/core/models/tv_show/tv_shows_list_model.dart';

part 'tv_shows_model.g.dart';

@JsonSerializable(createToJson: false, ignoreUnannotated: true)
final class TvShowsModel extends Equatable {
  @JsonKey(name: 'airing_today')
  final TvShowsListModel airingToday;
  @JsonKey(name: 'trending')
  final TvShowsListModel trending;
  @JsonKey(name: 'top_rated')
  final TvShowsListModel topRated;
  @JsonKey(name: 'popular')
  final TvShowsListModel popular;

  const TvShowsModel({
    required this.airingToday,
    required this.trending,
    required this.topRated,
    required this.popular,
  });

  factory TvShowsModel.fromJson(Map<String, dynamic> json) =>
      _$TvShowsModelFromJson(json);

  @override
  List<Object?> get props => [airingToday, trending, topRated, popular];
}
