import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../../../../../../core/api/utils/json_keys_names.dart';
import 'episode_model.dart';

part 'tv_show_season_details_model.g.dart';

@JsonSerializable(createToJson: false, ignoreUnannotated: true)
final class TvShowSeasonDetailsModel extends Equatable {
  @JsonKey(name: JsonKeysNames.name)
  final String name;
  @JsonKey(name: JsonKeysNames.airDate)
  final String airDate;
  @JsonKey(name: JsonKeysNames.overview)
  final String? overview;
  @JsonKey(name: JsonKeysNames.posterPath)
  final String? posterPath;
  @JsonKey(name: JsonKeysNames.episodes)
  final List<EpisodeModel> episodes;

  TvShowSeasonDetailsModel({
    required this.name,
    required this.airDate,
    required this.overview,
    required this.posterPath,
    required this.episodes,
  });

  factory TvShowSeasonDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$TvShowSeasonDetailsModelFromJson(json);

  @override
  List<Object?> get props => [
        name,
        airDate,
        overview,
        posterPath,
        episodes,
      ];
}
