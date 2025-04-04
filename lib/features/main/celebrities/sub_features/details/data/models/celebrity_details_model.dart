import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/features/main/celebrities/sub_features/details/data/models/movie_credits_model.dart';
import 'package:tmdb/features/main/celebrities/sub_features/details/data/models/tv_show_credits_model.dart';

import '../../../../../../../core/api/utils/json_keys_names.dart';

part 'celebrity_details_model.g.dart';

@JsonSerializable(createToJson: false, ignoreUnannotated: true)
final class CelebrityDetailsModel extends Equatable {
  @JsonKey(name: JsonKeysNames.name)
  final String name;
  @JsonKey(name: JsonKeysNames.knownForDept)
  final String? department;
  @JsonKey(name: JsonKeysNames.birthday)
  final String? birthday;
  @JsonKey(name: JsonKeysNames.deathDay)
  final String? deathDay;
  @JsonKey(name: JsonKeysNames.biography)
  final String? biography;
  @JsonKey(name: JsonKeysNames.birthPlace)
  final String? birthPlace;
  @JsonKey(name: JsonKeysNames.profilePath)
  final String? profilePath;
  @JsonKey(name: JsonKeysNames.movieCredits)
  final MovieCreditsModel? movieCredits;
  @JsonKey(name: JsonKeysNames.tvCredits)
  final TvShowCreditsModel? tvCredits;

  CelebrityDetailsModel(
      {required this.name,
      required this.department,
      required this.birthday,
      required this.deathDay,
      required this.biography,
      required this.birthPlace,
      required this.profilePath,
      required this.movieCredits,
      required this.tvCredits});

  factory CelebrityDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$CelebrityDetailsModelFromJson(json);

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
