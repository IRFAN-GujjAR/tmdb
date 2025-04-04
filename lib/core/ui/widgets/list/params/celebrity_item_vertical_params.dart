import 'package:tmdb/core/ui/widgets/list/params/celebrity_items_vertical_params.dart';

final class CelebrityItemVerticalParams {
  final int id;
  final String name;
  final String? knownFor;
  final String? profilePath;

  CelebrityItemVerticalParams({
    required this.id,
    required this.name,
    required this.knownFor,
    required this.profilePath,
  });

  factory CelebrityItemVerticalParams.fromCelebsParams(
    CelebrityItemsVerticalParams params,
    int index,
  ) {
    return CelebrityItemVerticalParams(
      id: params.celebsIds[index],
      name: params.celebsNames[index],
      knownFor: params.celebsKnownFor[index],
      profilePath: params.profilePaths[index],
    );
  }
}
