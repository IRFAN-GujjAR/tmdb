import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../api/utils/json_keys_names.dart';

class ProductionCompanyEntity extends Equatable {
  @JsonKey(name: JsonKeysNames.name)
  final String name;

  ProductionCompanyEntity({required this.name});

  List<Object?> get props => [name];
}
