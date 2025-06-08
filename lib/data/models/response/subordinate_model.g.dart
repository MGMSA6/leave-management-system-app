// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subordinate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubordinateModel _$SubordinateModelFromJson(Map<String, dynamic> json) =>
    SubordinateModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$SubordinateModelToJson(SubordinateModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
