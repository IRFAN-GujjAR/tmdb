// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backdrop_images_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BackdropImagesModel _$BackdropImagesModelFromJson(Map<String, dynamic> json) =>
    BackdropImagesModel(
      backdrops:
          (json['backdrops'] as List<dynamic>)
              .map(
                (e) => BackdropImageModel.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
    );
