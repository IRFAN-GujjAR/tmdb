import 'package:drift/drift.dart' as drift;
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/core/models/search/search_model.dart';

import '../../api/utils/json_keys_names.dart';

part 'searches_model.g.dart';

@JsonSerializable(explicitToJson: true, ignoreUnannotated: true)
final class SearchesModel extends Equatable {
  @JsonKey(name: JsonKeysNames.results)
  final List<SearchModel> searches;

  SearchesModel({required this.searches});

  factory SearchesModel.fromJson(Map<String, dynamic> json) =>
      _$SearchesModelFromJson(json);
  Map<String, dynamic> toJson() => _$SearchesModelToJson(this);

  static drift.JsonTypeConverter2<SearchesModel, drift.Uint8List, Object?>
  binaryConverter = drift.TypeConverter.jsonb(
    fromJson: (value) => SearchesModel.fromJson(value as Map<String, Object?>),
    toJson: (value) => value.toJson(),
  );

  @override
  List<Object?> get props => [searches];
}
