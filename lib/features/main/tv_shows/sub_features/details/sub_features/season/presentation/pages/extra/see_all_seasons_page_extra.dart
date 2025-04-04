import '../../../../../../../../../../core/entities/tv_show/season/season_entity.dart';

final class SeeAllSeasonsPageExtra {
  final int tvId;
  final String tvShowName;
  final String? tvShowPosterPath;
  final String? episodeImagePlaceHolder;
  final List<SeasonEntity> seasons;

  SeeAllSeasonsPageExtra({
    required this.tvId,
    required this.tvShowName,
    required this.tvShowPosterPath,
    required this.episodeImagePlaceHolder,
    required this.seasons,
  });
}
