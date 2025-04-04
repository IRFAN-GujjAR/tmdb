import 'package:tmdb/core/entities/common/credits/cast_entity.dart';
import 'package:tmdb/core/entities/common/credits/crew_entity.dart';

final class CreditsEntity {
  final List<CastEntity> cast;
  final List<CrewEntity> crew;

  CreditsEntity({required this.cast, required this.crew});
}
