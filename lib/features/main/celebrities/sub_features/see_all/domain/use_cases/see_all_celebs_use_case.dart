import 'package:tmdb/core/entities/celebs/celebrities_list_entity.dart';
import 'package:tmdb/features/main/celebrities/sub_features/see_all/domain/repositories/see_all_celebs_repo.dart';

import '../../../../../../../core/usecase/usecase.dart';

final class SeeAllCelebsUseCase
    extends UseCase<CelebritiesListEntity, Map<String, dynamic>> {
  final SeeAllCelebsRepo _repo;

  SeeAllCelebsUseCase(this._repo);

  @override
  Future<CelebritiesListEntity> call(Map<String, dynamic> params) =>
      _repo.loadCelebs(cfParams: params);
}
