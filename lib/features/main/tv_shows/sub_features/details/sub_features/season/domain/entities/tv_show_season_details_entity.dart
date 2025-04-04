import 'package:equatable/equatable.dart';

import 'episode_entity.dart';

final class TvShowSeasonDetailsEntity extends Equatable {
  final String name;
  final String airDate;
  final String? overview;
  final String? posterPath;
  final List<EpisodeEntity> episodes;

  TvShowSeasonDetailsEntity({
    required this.name,
    required this.airDate,
    required this.overview,
    required this.posterPath,
    required this.episodes,
  });

  @override
  List<Object?> get props => [
        name,
        airDate,
        overview,
        posterPath,
        episodes,
      ];
}
