// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_user_application_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentUserApplicationResponseModel
    _$CurrentUserApplicationResponseModelFromJson(Map<String, dynamic> json) =>
        CurrentUserApplicationResponseModel(
          wfh: (json['wfh'] as Map<String, dynamic>).map(
            (k, e) => MapEntry(
                k,
                (e as List<dynamic>)
                    .map((e) =>
                        ResponseModel.fromJson(e as Map<String, dynamic>))
                    .toList()),
          ),
          leave: (json['leave'] as Map<String, dynamic>).map(
            (k, e) => MapEntry(
                k,
                (e as List<dynamic>)
                    .map((e) =>
                        ResponseModel.fromJson(e as Map<String, dynamic>))
                    .toList()),
          ),
          permission: (json['permission'] as Map<String, dynamic>).map(
            (k, e) => MapEntry(
                k,
                (e as List<dynamic>)
                    .map((e) => PermissionResponseModel.fromJson(
                        e as Map<String, dynamic>))
                    .toList()),
          ),
        );

Map<String, dynamic> _$CurrentUserApplicationResponseModelToJson(
        CurrentUserApplicationResponseModel instance) =>
    <String, dynamic>{
      'wfh': instance.wfh,
      'leave': instance.leave,
      'permission': instance.permission,
    };
