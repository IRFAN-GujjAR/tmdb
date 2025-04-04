import 'package:tmdb/core/ui/widgets/list/params/media_items_horizontal_params.dart';

import '../../../utils.dart';
import 'config/media_items_horizontal_config.dart';

final class MediaItemHorizontalParams {
  final MediaType mediaType;
  final int mediaId;
  final String mediaTitle;
  final List<int> mediaGenre;
  final String? posterPath;
  final String? backdropPath;
  final bool isLandscape;
  final MediaItemsHorizontalConfig config;

  const MediaItemHorizontalParams({
    required this.mediaType,
    required this.mediaId,
    required this.mediaTitle,
    required this.mediaGenre,
    required this.posterPath,
    required this.backdropPath,
    required this.isLandscape,
    required this.config,
  });

  factory MediaItemHorizontalParams.fromListParams(
    MediaItemsHorizontalParams params,
    int index,
  ) {
    return MediaItemHorizontalParams(
      mediaType: params.mediaType,
      mediaId: params.mediaIds[index],
      mediaTitle: params.mediaTitles[index],
      mediaGenre: params.mediaGenres[index],
      posterPath: params.posterPaths[index],
      backdropPath: params.backdropPaths[index],
      isLandscape: params.isLandscape,
      config: params.config,
    );
  }
}
