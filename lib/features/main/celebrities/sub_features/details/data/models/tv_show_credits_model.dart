import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../../../../core/api/utils/json_keys_names.dart';
import '../../../../../../../core/models/tv_show/tv_show_model.dart';

part 'tv_show_credits_model.g.dart';

@JsonSerializable(createToJson: false, ignoreUnannotated: true)
final class TvShowCreditsModel extends Equatable {
  @JsonKey(name: JsonKeysNames.cast)
  final List<TvShowModel> cast;
  @JsonKey(name: JsonKeysNames.crew)
  final List<TvShowModel> crew;

  TvShowCreditsModel({required this.cast, required this.crew});

  factory TvShowCreditsModel.fromJson(Map<String, dynamic> json) =>
      _$TvShowCreditsModelFromJson(json);

  @override
  List<Object?> get props => [cast, crew];
}
