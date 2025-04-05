import 'package:json_annotation/json_annotation.dart';

import '../../../../../core/firebase/cloud_functions/cloud_functions_json_keys.dart';

part 'account_details_cf_params_data.g.dart';

@JsonSerializable(createFactory: false)
final class AccountDetailsCFParamsData {
  @JsonKey(name: CFJsonKeys.SESSION_ID)
  final String sessionId;

  const AccountDetailsCFParamsData({required this.sessionId});

  Map<String, dynamic> toJson() => _$AccountDetailsCFParamsDataToJson(this);
}
