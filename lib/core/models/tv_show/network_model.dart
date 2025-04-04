import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/core/entities/tv_show/network_entity.dart';

part 'network_model.g.dart';

@JsonSerializable(createToJson: false, ignoreUnannotated: true)
final class NetworkModel extends NetworkEntity {
  NetworkModel({required super.name});

  factory NetworkModel.fromJson(Map<String, dynamic> json) =>
      _$NetworkModelFromJson(json);
}
