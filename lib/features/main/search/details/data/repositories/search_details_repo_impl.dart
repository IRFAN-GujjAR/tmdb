import 'package:tmdb/core/entities/celebs/celebrities_list_entity.dart';
import 'package:tmdb/core/entities/movie/movies_list_entity.dart';
import 'package:tmdb/core/entities/tv_show/tv_shows_list_entity.dart';
import 'package:tmdb/features/main/search/details/domain/entities/search_details_entity.dart';
import 'package:tmdb/features/main/search/details/domain/repositories/search_details_repo.dart';

import '../data_sources/search_details_data_source.dart';

final class SearchDetailsRepoImpl implements SearchDetailsRepo {
  final SearchDetailsDataSource _dataSource;

  SearchDetailsRepoImpl(this._dataSource);

  @override
  Future<SearchDetailsEntity> loadDetails(String query) async {
    final model = await _dataSource.loadDetails(query);
    final moviesList = MoviesListEntity(
        pageNo: model.moviesList.pageNo,
        totalPages: model.moviesList.totalPages,
        movies: model.moviesList.movies);
    final tvShowsList = TvShowsListEntity(
        pageNo: model.tvShowsList.pageNo,
        totalPages: model.tvShowsList.totalPages,
        tvShows: model.tvShowsList.tvShows);
    final celebritiesList = CelebritiesListEntity(
        pageNo: model.celebritiesList.pageNo,
        totalPages: model.celebritiesList.totalPages,
        celebrities: model.celebritiesList.celebrities);
    return SearchDetailsEntity(
        moviesList: moviesList,
        tvShowsList: tvShowsList,
        celebritiesList: celebritiesList);
  }
}
