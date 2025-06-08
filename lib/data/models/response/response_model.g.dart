// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseModel _$ResponseModelFromJson(Map<String, dynamic> json) =>
    ResponseModel(
      id: (json['id'] as num).toInt(),
      requestType: json['requestType'] as String,
      userName: json['userName'] as String,
      userId: (json['userId'] as num).toInt(),
      fromDate: json['fromDate'] as String,
      toDate: json['toDate'] as String,
      reason: json['reason'] as String,
      remarks: json['remarks'] as String?,
      status: json['status'] as String,
      decidedBy:
          DecidedByModel.fromJson(json['decidedBy'] as Map<String, dynamic>),
      requestedWorkingDays: (json['requestedWorkingDays'] as num).toInt(),
      createdOn: json['createdOn'] as String,
      updatedOn: json['updatedOn'] as String,
    );

Map<String, dynamic> _$ResponseModelToJson(ResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'requestType': instance.requestType,
      'userName': instance.userName,
      'userId': instance.userId,
      'fromDate': instance.fromDate,
      'toDate': instance.toDate,
      'reason': instance.reason,
      'remarks': instance.remarks,
      'status': instance.status,
      'decidedBy': instance.decidedBy,
      'requestedWorkingDays': instance.requestedWorkingDays,
      'createdOn': instance.createdOn,
      'updatedOn': instance.updatedOn,
    };
