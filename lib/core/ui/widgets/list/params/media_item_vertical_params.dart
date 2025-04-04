import '../../../utils.dart';
import 'media_items_vertical_params.dart';

final class MediaItemVerticalParams {
  final MediaType mediaType;
  final int mediaId;
  final String mediaTitle;
  final List<int> mediaGenre;
  final String? posterPath;
  final String? backdropPath;
  final double voteAverage;
  final int voteCount;

  const MediaItemVerticalParams({
    required this.mediaType,
    required this.mediaId,
    required this.mediaTitle,
    required this.mediaGenre,
    required this.posterPath,
    required this.backdropPath,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MediaItemVerticalParams.fromListParams(
    MediaItemsVerticalParams params,
    int index,
  ) {
    return MediaItemVerticalParams(
      mediaType: params.mediaType,
      mediaId: params.mediaIds[index],
      mediaTitle: params.mediaTitles[index],
      mediaGenre: params.mediaGenres[index],
      posterPath: params.posterPaths[index],
      backdropPath: params.backdropPaths[index],
      voteAverage: params.voteAverages[index],
      voteCount: params.voteCounts[index],
    );
  }
}
