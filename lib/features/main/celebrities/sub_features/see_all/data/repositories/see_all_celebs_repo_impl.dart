import 'package:tmdb/core/entities/celebs/celebrities_list_entity.dart';
import 'package:tmdb/features/main/celebrities/sub_features/see_all/data/data_sources/see_all_celebs_data_source.dart';
import 'package:tmdb/features/main/celebrities/sub_features/see_all/domain/repositories/see_all_celebs_repo.dart';

final class SeeAllCelebsRepoImpl implements SeeAllCelebsRepo {
  final SeeAllCelebsDataSource _dataSource;

  SeeAllCelebsRepoImpl(this._dataSource);

  @override
  Future<CelebritiesListEntity> loadCelebs({
    required Map<String, dynamic> cfParams,
  }) async {
    final model = await _dataSource.loadCelebs(cfParams: cfParams);
    return CelebritiesListEntity(
      pageNo: model.pageNo,
      totalPages: model.totalPages,
      celebrities: model.celebrities,
    );
  }
}
