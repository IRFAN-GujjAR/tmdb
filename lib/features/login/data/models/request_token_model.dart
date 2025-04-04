import 'package:json_annotation/json_annotation.dart';

part 'request_token_model.g.dart';

@JsonSerializable()
final class RequestTokenModel {
  @JsonKey(name: 'request_token')
  final String requestToken;

  RequestTokenModel({required this.requestToken});

  factory RequestTokenModel.fromJson(Map<String, dynamic> json) =>
      _$RequestTokenModelFromJson(json);
  Map<String, dynamic> toJson() => _$RequestTokenModelToJson(this);
}
