import 'package:json_annotation/json_annotation.dart';

part 'season_cf_params_data.g.dart';

@JsonSerializable(createFactory: false)
final class SeasonCFParamsData {
  @JsonKey(name: 'tv_id')
  final int tvId;
  @JsonKey(name: 'season_no')
  final int seasonNo;

  const SeasonCFParamsData({required this.tvId, required this.seasonNo});

  Map<String, dynamic> toJson() => _$SeasonCFParamsDataToJson(this);
}
