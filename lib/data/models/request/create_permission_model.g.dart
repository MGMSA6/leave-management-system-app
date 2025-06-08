// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_permission_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatePermissionModel _$CreatePermissionModelFromJson(
        Map<String, dynamic> json) =>
    CreatePermissionModel(
      managerId: (json['managerId'] as num).toInt(),
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      reason: json['reason'] as String,
    );

Map<String, dynamic> _$CreatePermissionModelToJson(
        CreatePermissionModel instance) =>
    <String, dynamic>{
      'managerId': instance.managerId,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'reason': instance.reason,
    };
