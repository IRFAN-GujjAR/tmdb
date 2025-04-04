import 'package:drift/drift.dart' as drift;
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../api/utils/json_keys_names.dart';
import 'celebrity_model.dart';

part 'celebrities_list_model.g.dart';

@JsonSerializable(explicitToJson: true, ignoreUnannotated: true)
final class CelebritiesListModel extends Equatable {
  @JsonKey(name: JsonKeysNames.pageNo)
  final int pageNo;
  @JsonKey(name: JsonKeysNames.totalPages)
  final int totalPages;
  @JsonKey(name: JsonKeysNames.results)
  final List<CelebrityModel> celebrities;

  const CelebritiesListModel({
    required this.pageNo,
    required this.totalPages,
    required this.celebrities,
  });

  factory CelebritiesListModel.fromJson(Map<String, dynamic> json) =>
      _$CelebritiesListModelFromJson(json);
  Map<String, dynamic> toJson() => _$CelebritiesListModelToJson(this);

  static drift.JsonTypeConverter2<
    CelebritiesListModel,
    drift.Uint8List,
    Object?
  >
  binaryConverter = drift.TypeConverter.jsonb(
    fromJson:
        (value) => CelebritiesListModel.fromJson(value as Map<String, Object?>),
    toJson: (value) => value.toJson(),
  );

  @override
  List<Object?> get props => [pageNo, totalPages, celebrities];
}
