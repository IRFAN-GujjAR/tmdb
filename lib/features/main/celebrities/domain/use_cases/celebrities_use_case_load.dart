import 'package:tmdb/core/usecase/usecase.dart';
import 'package:tmdb/features/main/celebrities/domain/repositories/celebrities_repo.dart';

final class CelebritiesUseCaseLoad
    implements UseCaseWithoutParamsAndReturnType {
  final CelebritiesRepo _repo;

  CelebritiesUseCaseLoad(this._repo);

  @override
  Future<void> get call => _repo.loadCelebrities;
}
