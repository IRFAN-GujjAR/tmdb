import 'package:tmdb/core/entities/celebs/celebrity_entity.dart';

import 'config/celebrity_item_config.dart';

final class CelebrityItemsParams {
  final List<int> celebsIds;
  final List<String> celebsNames;
  final List<String?> celebsKnownFor;
  final List<String?> profilePaths;
  final CelebrityItemConfig config;

  CelebrityItemsParams({
    required this.celebsIds,
    required this.celebsNames,
    required this.celebsKnownFor,
    required this.profilePaths,
    required this.config,
  });

  factory CelebrityItemsParams.fromCelebs(
    List<CelebrityEntity> celebs, {
    required CelebrityItemConfig config,
  }) {
    return CelebrityItemsParams(
      celebsIds: celebs.map((e) => e.id).toList(),
      celebsNames: celebs.map((e) => e.name).toList(),
      celebsKnownFor: celebs.map((e) => e.knownFor).toList(),
      profilePaths: celebs.map((e) => e.profilePath).toList(),
      config: config,
    );
  }
}
