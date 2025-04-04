import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/core/entities/common/production_company_entity.dart';

part 'production_company_model.g.dart';

@JsonSerializable(createToJson: false, ignoreUnannotated: true)
final class ProductionCompanyModel extends ProductionCompanyEntity {
  ProductionCompanyModel({required super.name});

  factory ProductionCompanyModel.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompanyModelFromJson(json);
}
