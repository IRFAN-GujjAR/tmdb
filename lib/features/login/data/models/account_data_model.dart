import 'package:json_annotation/json_annotation.dart';

part 'account_data_model.g.dart';

@JsonSerializable(createToJson: false)
final class AccountDataModel {
  final int id;
  final String username;

  const AccountDataModel({required this.id, required this.username});

  factory AccountDataModel.fromJson(Map<String, dynamic> json) =>
      _$AccountDataModelFromJson(json);
}
