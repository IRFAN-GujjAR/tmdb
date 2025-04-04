import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../../../../../../core/api/utils/json_keys_names.dart';

class EpisodeEntity extends Equatable {
  @JsonKey(name: JsonKeysNames.name)
  final String name;
  @JsonKey(name: JsonKeysNames.airDate)
  final String? airDate;
  @JsonKey(name: JsonKeysNames.overview)
  final String? overview;
  @JsonKey(name: JsonKeysNames.stillPath)
  final String? stillPath;
  @JsonKey(name: JsonKeysNames.voteCount)
  final int voteCount;
  @JsonKey(name: JsonKeysNames.voteAverage)
  final double voteAverage;

  EpisodeEntity({
    required this.name,
    required this.airDate,
    required this.overview,
    required this.stillPath,
    required this.voteCount,
    required this.voteAverage,
  });

  @override
  List<Object?> get props => [
        name,
        airDate,
        overview,
        stillPath,
        voteCount,
        voteAverage,
      ];
}
