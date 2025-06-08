// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateRequestModel _$CreateRequestModelFromJson(Map<String, dynamic> json) =>
    CreateRequestModel(
      requestType: json['requestType'] as String,
      fromDate: json['fromDate'] as String,
      toDate: json['toDate'] as String,
      reason: json['reason'] as String,
      decidedBy: (json['decidedBy'] as num).toInt(),
    );

Map<String, dynamic> _$CreateRequestModelToJson(CreateRequestModel instance) =>
    <String, dynamic>{
      'requestType': instance.requestType,
      'fromDate': instance.fromDate,
      'toDate': instance.toDate,
      'reason': instance.reason,
      'decidedBy': instance.decidedBy,
    };
