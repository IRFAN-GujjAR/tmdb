import 'package:drift/drift.dart' as drift;
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/core/models/tv_show/tv_show_model.dart';

import '../../api/utils/json_keys_names.dart';
import '../../entities/tv_show/tv_shows_list_entity.dart';

part 'tv_shows_list_model.g.dart';

@JsonSerializable(explicitToJson: true, ignoreUnannotated: true)
final class TvShowsListModel extends Equatable {
  @JsonKey(name: JsonKeysNames.pageNo)
  final int pageNo;
  @JsonKey(name: JsonKeysNames.totalPages)
  final int totalPages;
  @JsonKey(name: JsonKeysNames.results)
  final List<TvShowModel> tvShows;

  const TvShowsListModel({
    required this.pageNo,
    required this.totalPages,
    required this.tvShows,
  });

  factory TvShowsListModel.fromJson(Map<String, dynamic> json) =>
      _$TvShowsListModelFromJson(json);

  Map<String, dynamic> toJson() => _$TvShowsListModelToJson(this);

  TvShowsListEntity get toEntity => TvShowsListEntity(
    pageNo: pageNo,
    totalPages: totalPages,
    tvShows: tvShows,
  );

  static drift.JsonTypeConverter2<TvShowsListModel, drift.Uint8List, Object?>
  binaryConverter = drift.TypeConverter.jsonb(
    fromJson:
        (value) => TvShowsListModel.fromJson(value as Map<String, Object?>),
    toJson: (value) => value.toJson(),
  );

  @override
  List<Object?> get props => [pageNo, totalPages, tvShows];
}
