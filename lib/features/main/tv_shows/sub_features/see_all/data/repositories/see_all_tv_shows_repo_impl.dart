import 'package:tmdb/core/entities/tv_show/tv_shows_list_entity.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/see_all/data/data_sources/see_all_tv_shows_data_source.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/see_all/domain/repositories/see_all_tv_shows_repo.dart';

final class SeeAllTvShowsRepoImpl implements SeeAllTvShowsRepo {
  final SeeAllTvShowsDataSource _dataSource;

  SeeAllTvShowsRepoImpl(this._dataSource);

  @override
  Future<TvShowsListEntity> getTvShows({
    required Map<String, dynamic> cfParams,
  }) async {
    final tvShowsListModel = await _dataSource.getTvShows(cfParams: cfParams);
    return TvShowsListEntity(
      pageNo: tvShowsListModel.pageNo,
      totalPages: tvShowsListModel.totalPages,
      tvShows: tvShowsListModel.tvShows,
    );
  }
}
