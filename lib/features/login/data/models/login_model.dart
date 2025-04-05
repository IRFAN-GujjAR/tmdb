import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/features/main/tmdb/data/models/account_details_model.dart';

import '../../../../core/firebase/cloud_functions/cloud_functions_json_keys.dart';

part 'login_model.g.dart';

@JsonSerializable(createToJson: false, ignoreUnannotated: true)
final class LoginModel extends Equatable {
  @JsonKey(name: CFJsonKeys.SESSION_ID)
  final String sessionId;
  @JsonKey(name: CFJsonKeys.ACCOUNT_DETAILS)
  final AccountDetailsModel accountDetails;

  const LoginModel({required this.sessionId, required this.accountDetails});

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);

  @override
  List<Object?> get props => [sessionId, accountDetails];
}
