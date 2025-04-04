import 'package:flutter/material.dart';
import 'package:tmdb/core/entities/celebs/celebrity_entity.dart';

final class CelebrityItemsVerticalParams {
  final List<int> celebsIds;
  final List<String> celebsNames;
  final List<String?> celebsKnownFor;
  final List<String?> profilePaths;
  final ScrollController scrollController;

  CelebrityItemsVerticalParams({
    required this.celebsIds,
    required this.celebsNames,
    required this.celebsKnownFor,
    required this.profilePaths,
    required this.scrollController,
  });

  factory CelebrityItemsVerticalParams.fromCelebs(
    List<CelebrityEntity> celebs, {
    required ScrollController scrollController,
  }) {
    return CelebrityItemsVerticalParams(
      celebsIds: celebs.map((e) => e.id).toList(),
      celebsNames: celebs.map((e) => e.name).toList(),
      celebsKnownFor: celebs.map((e) => e.knownFor).toList(),
      profilePaths: celebs.map((e) => e.profilePath).toList(),
      scrollController: scrollController,
    );
  }
}
