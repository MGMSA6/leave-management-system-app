// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllResponseModel _$AllResponseModelFromJson(Map<String, dynamic> json) =>
    AllResponseModel(
      wfh: (json['wfh'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k,
            (e as List<dynamic>)
                .map((e) => ResponseModel.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
      leave: (json['leave'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k,
            (e as List<dynamic>)
                .map((e) => ResponseModel.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
      permission: (json['permission'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k,
            (e as List<dynamic>)
                .map((e) =>
                    PermissionResponseModel.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
    );

Map<String, dynamic> _$AllResponseModelToJson(AllResponseModel instance) =>
    <String, dynamic>{
      'wfh': instance.wfh,
      'leave': instance.leave,
      'permission': instance.permission,
    };
