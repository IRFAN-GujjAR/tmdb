import 'package:tmdb/features/main/celebrities/sub_features/details/domain/entities/celebrity_details_entity.dart';

abstract class CelebritiesDetailsRepo {
  Future<CelebrityDetailsEntity> loadDetails({required int celebId});
}
