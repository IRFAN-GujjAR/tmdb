import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/core/models/celebs/celebrities_list_model.dart';

part 'celebrities_model.g.dart';

@JsonSerializable(createToJson: false, ignoreUnannotated: true)
final class CelebritiesModel extends Equatable {
  @JsonKey(name: 'popular')
  final CelebritiesListModel popular;
  @JsonKey(name: 'trending')
  final CelebritiesListModel trending;

  const CelebritiesModel({required this.popular, required this.trending});

  factory CelebritiesModel.fromJson(Map<String, dynamic> json) =>
      _$CelebritiesModelFromJson(json);

  @override
  List<Object?> get props => [popular, trending];
}
