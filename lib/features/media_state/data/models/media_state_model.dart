import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/features/media_state/data/models/rated_model.dart';

import '../../../../core/api/utils/json_keys_names.dart';
import 'converters/rated_model_converter.dart';

part 'media_state_model.g.dart';

@JsonSerializable(createToJson: false, ignoreUnannotated: true)
final class MediaStateModel extends Equatable {
  @JsonKey(name: JsonKeysNames.id)
  final int id;
  @JsonKey(name: JsonKeysNames.favorite)
  final bool favorite;
  @JsonKey(name: JsonKeysNames.rated, fromJson: RatedModelConverter.fromJson)
  final RatedModel rated;
  @JsonKey(name: JsonKeysNames.watchlist)
  final bool watchlist;

  const MediaStateModel({
    required this.id,
    required this.favorite,
    required this.rated,
    required this.watchlist,
  });

  factory MediaStateModel.fromJson(Map<String, dynamic> json) =>
      _$MediaStateModelFromJson(json);

  @override
  List<Object?> get props => [id, favorite, rated, watchlist];
}
