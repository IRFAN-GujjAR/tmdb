// final body =
//         '{ "media_type": "${MEDIA_TYPE_VALUE[_mediaType]}","media_id": $mediaId,"favorite": $mark}';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../../../../core/api/utils/json_keys_names.dart';

class FavoriteMediaEntity extends Equatable {
  @JsonKey(name: JsonKeysNames.mediaType)
  final String mediaType;
  @JsonKey(name: JsonKeysNames.mediaId)
  final int mediaId;
  @JsonKey(name: JsonKeysNames.favorite)
  final bool set;

  FavoriteMediaEntity(
      {required this.mediaType, required this.mediaId, required this.set});

  @override
  List<Object?> get props => [mediaType, mediaId, set];
}
