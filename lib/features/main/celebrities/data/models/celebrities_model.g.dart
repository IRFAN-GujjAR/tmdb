// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'celebrities_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CelebritiesModel _$CelebritiesModelFromJson(Map<String, dynamic> json) =>
    CelebritiesModel(
      popular: CelebritiesListModel.fromJson(
        json['popular'] as Map<String, dynamic>,
      ),
      trending: CelebritiesListModel.fromJson(
        json['trending'] as Map<String, dynamic>,
      ),
    );
