import 'package:json_annotation/json_annotation.dart';

import '../../../api/utils/json_keys_names.dart';
import 'cast_model.dart';
import 'crew_model.dart';

part 'credits_model.g.dart';

@JsonSerializable(createToJson: false, ignoreUnannotated: true)
final class CreditsModel {
  @JsonKey(name: JsonKeysNames.cast)
  final List<CastModel> cast;
  @JsonKey(name: JsonKeysNames.crew)
  final List<CrewModel> crew;

  CreditsModel({required this.cast, required this.crew});

  factory CreditsModel.fromJson(Map<String, dynamic> json) {
    final credits = _$CreditsModelFromJson(json);
    final casts = credits.cast;
    final crews = credits.crew;

    List<CrewModel> correctedCrews = [];

    if (crews.isNotEmpty) {
      for (int i = 0; i < crews.length; i++) {
        if (correctedCrews.isEmpty) {
          String job = crews[i].job != null ? crews[i].job ?? '' : '';
          for (int j = i + 1; j < crews.length; j++) {
            if (crews[i].id == crews[j].id) {
              if (crews[j].job != null) {
                job += crews[j].job != null ? ', ${crews[j].job}' : '';
              }
            }
          }
          correctedCrews.add(CrewModel(
              id: crews[i].id,
              name: crews[i].name,
              job: job,
              department: crews[i].department,
              profilePath: crews[i].profilePath));
        } else {
          bool isSame = false;
          correctedCrews.forEach((crew) {
            if (crew.id == crews[i].id) {
              isSame = true;
            }
          });
          if (!isSame) {
            String job = crews[i].job != null ? crews[i].job ?? '' : '';
            for (int j = i + 1; j < crews.length; j++) {
              if (crews[i].id == crews[j].id) {
                if (crews[j].job != null) {
                  job += crews[j].job != null ? ', ${crews[j].job}' : '';
                }
              }
            }
            correctedCrews.add(CrewModel(
                id: crews[i].id,
                name: crews[i].name,
                job: job,
                department: crews[i].department,
                profilePath: crews[i].profilePath));
          }
        }
      }
    }
    return CreditsModel(cast: casts, crew: correctedCrews);
  }
}
