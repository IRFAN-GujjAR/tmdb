import 'package:tmdb/core/entities/tv_show/tv_shows_list_entity.dart';
import 'package:tmdb/core/models/tv_show/tv_shows_list_model.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/details/data/data_sources/tv_show_details_data_source.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/details/domain/entities/tv_show_details_entity.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/details/domain/repositories/tv_show_details_repo.dart';

import '../../../../../../../core/entities/common/backdrops/backdrop_image_entity.dart';
import '../../../../../../../core/entities/common/credits/credits_entity.dart';
import '../../../../../../../core/entities/common/videos/video_entity.dart';

final class TvShowDetailsRepoImpl implements TvShowDetailsRepo {
  final TvShowDetailsDataSource _dataSource;

  TvShowDetailsRepoImpl(this._dataSource);

  @override
  Future<TvShowDetailsEntity> loadTvShowDetails(int tvId) async {
    final tvShowDetails = await _dataSource.loadTvShowDetails(tvId);
    CreditsEntity? credits;
    if (tvShowDetails.credits != null) {
      credits = CreditsEntity(
          cast: tvShowDetails.credits!.cast, crew: tvShowDetails.credits!.crew);
    }
    final images = tvShowDetails.images.backdrops
        .map((e) => BackdropImageEntity(filePath: e.filePath))
        .toList();
    final videos = tvShowDetails.videos.videos
        .map((e) => VideoEntity(key: e.key, name: e.name))
        .toList();
    TvShowsListModel? recommendedModel = tvShowDetails.recommendedTvShows;
    TvShowsListEntity? recommendedEntity;
    if (recommendedModel != null) {
      recommendedEntity = TvShowsListEntity(
          pageNo: recommendedModel.pageNo,
          totalPages: recommendedModel.totalPages,
          tvShows: recommendedModel.tvShows);
    }

    TvShowsListModel? similarModel = tvShowDetails.similarTvShows;
    TvShowsListEntity? similarEntity;
    if (similarModel != null) {
      similarEntity = TvShowsListEntity(
          pageNo: similarModel.pageNo,
          totalPages: similarModel.totalPages,
          tvShows: similarModel.tvShows);
    }
    return TvShowDetailsEntity(
        backdropPath: tvShowDetails.backdropPath,
        posterPath: tvShowDetails.posterPath,
        name: tvShowDetails.name,
        voteAverage: tvShowDetails.voteAverage,
        voteCount: tvShowDetails.voteCount,
        genres: tvShowDetails.genres,
        overview: tvShowDetails.overview,
        seasons: tvShowDetails.seasons,
        credits: credits,
        images: images,
        videos: videos,
        createBy: tvShowDetails.createBy,
        firstAirDate: tvShowDetails.firstAirDate,
        language: tvShowDetails.language,
        countryOrigin: tvShowDetails.countryOrigin,
        networks: tvShowDetails.networks,
        productionCompanies: tvShowDetails.productionCompanies,
        recommendedTvShows: recommendedEntity,
        similarTvShows: similarEntity);
  }
}
