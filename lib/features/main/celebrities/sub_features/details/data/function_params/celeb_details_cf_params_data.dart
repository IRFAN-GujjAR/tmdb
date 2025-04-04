import 'package:json_annotation/json_annotation.dart';

import '../../../../../../../core/firebase/cloud_functions/cloud_functions_json_keys.dart';

part 'celeb_details_cf_params_data.g.dart';

@JsonSerializable(createFactory: false)
final class CelebDetailsCfParamsData {
  @JsonKey(name: CFJsonKeys.PERSON_ID)
  final int personId;

  const CelebDetailsCfParamsData(this.personId);

  Map<String, dynamic> toJson() => _$CelebDetailsCfParamsDataToJson(this);
}
