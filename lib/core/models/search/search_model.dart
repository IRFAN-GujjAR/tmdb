import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../api/utils/json_keys_names.dart';

part 'search_model.g.dart';

@JsonSerializable(ignoreUnannotated: true)
final class SearchModel extends Equatable {
  @JsonKey(name: JsonKeysNames.mediaType)
  final String mediaType;
  @JsonKey(name: JsonKeysNames.title)
  final String? title;
  @JsonKey(name: JsonKeysNames.name)
  final String? name;

  const SearchModel({
    required this.mediaType,
    required this.title,
    required this.name,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) =>
      _$SearchModelFromJson(json);
  Map<String, dynamic> toJson() => _$SearchModelToJson(this);

  String get searchTitle => mediaType == 'movie' ? title! : name!;

  @override
  List<Object?> get props => [mediaType, title, name];
}
