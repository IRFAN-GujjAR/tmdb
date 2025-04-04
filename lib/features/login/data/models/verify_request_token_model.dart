import 'package:json_annotation/json_annotation.dart';

part 'verify_request_token_model.g.dart';

@JsonSerializable(createFactory: false)
final class VerifyRequestTokenModel {
  @JsonKey(name: 'request_token')
  final String requestToken;
  final String username;
  final String password;

  VerifyRequestTokenModel(
      {required this.requestToken,
      required this.username,
      required this.password});

  Map<String, dynamic> toJson() => _$VerifyRequestTokenModelToJson(this);
}
