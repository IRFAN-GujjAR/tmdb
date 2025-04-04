import 'package:json_annotation/json_annotation.dart';

part 'tv_show_details_cf_params_data.g.dart';

@JsonSerializable(createFactory: false)
final class TvShowDetailsCFParamsData {
  @JsonKey(name: "tv_id")
  final int tvId;

  const TvShowDetailsCFParamsData({required this.tvId});

  Map<String, dynamic> toJson() => _$TvShowDetailsCFParamsDataToJson(this);
}
