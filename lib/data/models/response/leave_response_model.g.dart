// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveResponseModel _$LeaveResponseModelFromJson(Map<String, dynamic> json) =>
    LeaveResponseModel(
      id: (json['id'] as num).toInt(),
      requestType: json['requestType'] as String,
      userName: json['userName'] as String,
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

Map<String, dynamic> _$LeaveResponseModelToJson(LeaveResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'requestType': instance.requestType,
      'userName': instance.userName,
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
