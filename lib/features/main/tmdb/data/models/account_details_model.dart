import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account_details_model.g.dart';

@JsonSerializable(explicitToJson: true, ignoreUnannotated: true)
final class AccountDetailsModel extends Equatable {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'username')
  final String username;
  @JsonKey(name: 'avatar')
  final AvatarModel avatar;

  const AccountDetailsModel({
    required this.id,
    required this.username,
    required this.avatar,
  });

  factory AccountDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$AccountDetailsModelFromJson(json);
  Map<String, dynamic> toJson() => _$AccountDetailsModelToJson(this);

  @override
  List<Object?> get props => [id, username, avatar];
}

@JsonSerializable(explicitToJson: true, ignoreUnannotated: true)
final class AvatarModel extends Equatable {
  @JsonKey(name: 'tmdb')
  final AvatarPathModel avatarPath;

  const AvatarModel(this.avatarPath);

  factory AvatarModel.fromJson(Map<String, dynamic> json) =>
      _$AvatarModelFromJson(json);
  Map<String, dynamic> toJson() => _$AvatarModelToJson(this);

  @override
  List<Object?> get props => [avatarPath];
}

@JsonSerializable(ignoreUnannotated: true)
final class AvatarPathModel extends Equatable {
  @JsonKey(name: 'avatar_path')
  final String? profilePath;

  const AvatarPathModel(this.profilePath);

  factory AvatarPathModel.fromJson(Map<String, dynamic> json) =>
      _$AvatarPathModelFromJson(json);

  Map<String, dynamic> toJson() => _$AvatarPathModelToJson(this);

  @override
  List<Object?> get props => [profilePath];
}
