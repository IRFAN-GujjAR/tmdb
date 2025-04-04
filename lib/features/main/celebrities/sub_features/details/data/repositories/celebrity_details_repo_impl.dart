import 'package:tmdb/core/ui/date/date_utl.dart';
import 'package:tmdb/features/main/celebrities/sub_features/details/data/data_sources/celebrity_details_data_source.dart';
import 'package:tmdb/features/main/celebrities/sub_features/details/domain/entities/movie_credits_entity.dart';
import 'package:tmdb/features/main/celebrities/sub_features/details/domain/entities/tv_show_credits_entity.dart';
import 'package:tmdb/features/main/celebrities/sub_features/details/domain/repositories/celebrity_details_repo.dart';

import '../../domain/entities/celebrity_details_entity.dart';

final class CelebritiesDetailsRepoImpl implements CelebritiesDetailsRepo {
  final CelebritiesDetailsDataSource _dataSource;

  CelebritiesDetailsRepoImpl(this._dataSource);

  @override
  Future<CelebrityDetailsEntity> loadDetails({required int celebId}) async {
    final model = await _dataSource.loadDetails(celebId: celebId);
    final modelMovieCredits = model.movieCredits;
    MovieCreditsEntity? entityMovieCredits;
    if (modelMovieCredits != null) {
      entityMovieCredits = MovieCreditsEntity(
          cast: modelMovieCredits.cast, crew: modelMovieCredits.crew);
    }
    final modelTvCredits = model.tvCredits;
    TvShowCreditsEntity? entityTvShowCredits;
    if (modelTvCredits != null) {
      entityTvShowCredits = TvShowCreditsEntity(
          cast: modelTvCredits.cast, crew: modelTvCredits.crew);
    }

    return CelebrityDetailsEntity(
        name: model.name,
        department: model.department,
        birthday: DateUtl.formatDate(model.birthday),
        deathDay: DateUtl.formatDate(model.deathDay),
        biography: model.biography,
        birthPlace: model.birthPlace,
        profilePath: model.profilePath,
        movieCredits: entityMovieCredits,
        tvCredits: entityTvShowCredits);
  }
}
