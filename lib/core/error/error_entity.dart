import 'package:json_annotation/json_annotation.dart';

part 'error_entity.g.dart';

@JsonSerializable(createToJson: false)
final class ErrorEntity {
  @JsonKey(name: 'error_message')
  final String errorMessage;
  @JsonKey(name: 'http_code')
  final int httpCode;
  @JsonKey(name: 'tmdb_code')
  final int tMDBCode;

  const ErrorEntity({
    required this.errorMessage,
    required this.httpCode,
    required this.tMDBCode,
  });

  factory ErrorEntity.fromJson(Map<String, dynamic> json) =>
      _$ErrorEntityFromJson(json);
}
