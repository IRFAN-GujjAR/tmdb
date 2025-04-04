import 'package:tmdb/core/database/app_database.dart';
import 'package:tmdb/core/usecase/usecase.dart';
import 'package:tmdb/features/main/celebrities/domain/repositories/celebrities_repo.dart';

final class CelebritiesUseCaseWatch
    implements UseCaseWithoutAsyncAndParams<Stream<CelebsTableData?>> {
  final CelebritiesRepo _repo;

  const CelebritiesUseCaseWatch(this._repo);

  @override
  Stream<CelebsTableData?> get call => _repo.watchCelebs;
}
