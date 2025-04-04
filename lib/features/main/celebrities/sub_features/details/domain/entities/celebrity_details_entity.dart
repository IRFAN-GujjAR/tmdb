import 'package:equatable/equatable.dart';
import 'package:tmdb/features/main/celebrities/sub_features/details/domain/entities/movie_credits_entity.dart';
import 'package:tmdb/features/main/celebrities/sub_features/details/domain/entities/tv_show_credits_entity.dart';

final class CelebrityDetailsEntity extends Equatable {
  final String name;
  final String? department;
  final String? birthday;
  final String? deathDay;
  final String? biography;
  final String? birthPlace;
  final String? profilePath;
  final MovieCreditsEntity? movieCredits;
  final TvShowCreditsEntity? tvCredits;

  CelebrityDetailsEntity(
      {required this.name,
      required this.department,
      required this.birthday,
      required this.deathDay,
      required this.biography,
      required this.birthPlace,
      required this.profilePath,
      required this.movieCredits,
      required this.tvCredits});

  @override
  List<Object?> get props => [
        name,
        department,
        birthday,
        deathDay,
        biography,
        birthPlace,
        profilePath,
        movieCredits,
        tvCredits
      ];
}
