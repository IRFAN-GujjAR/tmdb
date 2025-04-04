import 'package:json_annotation/json_annotation.dart';

part 'session_id_model.g.dart';

@JsonSerializable(createToJson: false)
final class SessionIdModel {
  @JsonKey(name: 'session_id')
  final String sessionId;

  SessionIdModel({required this.sessionId});

  factory SessionIdModel.fromJson(Map<String, dynamic> json) =>
      _$SessionIdModelFromJson(json);
}
