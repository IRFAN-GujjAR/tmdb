import 'package:tmdb/core/usecase/usecase.dart';
import 'package:tmdb/features/main/celebrities/sub_features/details/domain/entities/celebrity_details_entity.dart';
import 'package:tmdb/features/main/celebrities/sub_features/details/domain/repositories/celebrity_details_repo.dart';

final class CelebrityDetailsUseCase
    implements UseCase<CelebrityDetailsEntity, int> {
  final CelebritiesDetailsRepo _repo;

  CelebrityDetailsUseCase(this._repo);

  @override
  Future<CelebrityDetailsEntity> call(int celebId) =>
      _repo.loadDetails(celebId: celebId);
}
