// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permission_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PermissionResponseModel _$PermissionResponseModelFromJson(
        Map<String, dynamic> json) =>
    PermissionResponseModel(
      id: (json['id'] as num).toInt(),
      employeeId: (json['employeeId'] as num).toInt(),
      employeeName: json['employeeName'] as String,
      managerId: (json['managerId'] as num).toInt(),
      managerName: json['managerName'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      durationMinutes: (json['durationMinutes'] as num).toInt(),
      reason: json['reason'] as String,
      status: json['status'] as String,
      createdOn: json['createdOn'] as String,
      updatedOn: json['updatedOn'] as String,
    );

Map<String, dynamic> _$PermissionResponseModelToJson(
        PermissionResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employeeId': instance.employeeId,
      'employeeName': instance.employeeName,
      'managerId': instance.managerId,
      'managerName': instance.managerName,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'durationMinutes': instance.durationMinutes,
      'reason': instance.reason,
      'status': instance.status,
      'createdOn': instance.createdOn,
      'updatedOn': instance.updatedOn,
    };
