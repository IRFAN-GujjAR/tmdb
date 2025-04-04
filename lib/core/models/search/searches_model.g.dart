// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'searches_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchesModel _$SearchesModelFromJson(Map<String, dynamic> json) =>
    SearchesModel(
      searches:
          (json['results'] as List<dynamic>)
              .map((e) => SearchModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$SearchesModelToJson(SearchesModel instance) =>
    <String, dynamic>{
      'results': instance.searches.map((e) => e.toJson()).toList(),
    };
