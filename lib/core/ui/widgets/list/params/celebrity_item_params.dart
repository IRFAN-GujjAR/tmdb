import 'package:tmdb/core/ui/widgets/list/params/celebrity_items_params.dart';
import 'package:tmdb/core/ui/widgets/list/params/config/celebrity_item_config.dart';

final class CelebrityItemParams {
  final int id;
  final String name;
  final String? knownFor;
  final String? profilePath;
  final CelebrityItemConfig config;

  const CelebrityItemParams({
    required this.id,
    required this.name,
    required this.knownFor,
    required this.profilePath,
    required this.config,
  });

  factory CelebrityItemParams.fromListParams(
    CelebrityItemsParams params,
    int index,
  ) {
    return CelebrityItemParams(
      id: params.celebsIds[index],
      name: params.celebsNames[index],
      knownFor: params.celebsKnownFor[index],
      profilePath: params.profilePaths[index],
      config: params.config,
    );
  }
}
