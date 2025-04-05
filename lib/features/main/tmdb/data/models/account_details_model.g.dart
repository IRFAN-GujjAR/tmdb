// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountDetailsModel _$AccountDetailsModelFromJson(Map<String, dynamic> json) =>
    AccountDetailsModel(
      id: (json['id'] as num).toInt(),
      username: json['username'] as String,
      avatar: AvatarModel.fromJson(json['avatar'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AccountDetailsModelToJson(
  AccountDetailsModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'avatar': instance.avatar.toJson(),
};

AvatarModel _$AvatarModelFromJson(Map<String, dynamic> json) =>
    AvatarModel(AvatarPathModel.fromJson(json['tmdb'] as Map<String, dynamic>));

Map<String, dynamic> _$AvatarModelToJson(AvatarModel instance) =>
    <String, dynamic>{'tmdb': instance.avatarPath.toJson()};

AvatarPathModel _$AvatarPathModelFromJson(Map<String, dynamic> json) =>
    AvatarPathModel(json['avatar_path'] as String?);

Map<String, dynamic> _$AvatarPathModelToJson(AvatarPathModel instance) =>
    <String, dynamic>{'avatar_path': instance.profilePath};
