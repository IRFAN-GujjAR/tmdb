import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/features/media_state/domain/entities/rated_entity.dart';

import '../../../../core/api/utils/json_keys_names.dart';

final class MediaStateEntity extends Equatable {
  @JsonKey(name: JsonKeysNames.id)
  final int id;
  @JsonKey(name: JsonKeysNames.favorite)
  final bool favorite;
  @JsonKey(name: JsonKeysNames.rated)
  final RatedEntity rated;
  @JsonKey(name: JsonKeysNames.watchlist)
  final bool watchlist;

  bool get isRated => rated.value != 0;
  // double get rating => _rated is bool ? 0 : _rated[JsonKeysNames.value];

  const MediaStateEntity({
    required this.id,
    required this.favorite,
    required this.rated,
    required this.watchlist,
  });

  // factory MediaStateModel.fromJson(Map<String, dynamic> json) =>
  //     MediaStateModel(
  //       id: json["id"],
  //       favorite: json["favorite"],
  //       rated: json['rated'] is bool ? json['rated'] : true,
  //       rating: json['rated'] is bool ? 0 : json['rated']['value'],
  //       watchlist: json["watchlist"],
  //     );
  //
  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "favorite": favorite,
  //       "rated": rated,
  //       "rating": rating,
  //       "watchlist": watchlist,
  //     };

  @override
  List<Object?> get props => [id, favorite, rated, watchlist];
}
