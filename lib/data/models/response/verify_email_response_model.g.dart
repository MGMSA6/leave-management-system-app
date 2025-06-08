// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_email_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyEmailResponseModel _$VerifyEmailResponseModelFromJson(
        Map<String, dynamic> json) =>
    VerifyEmailResponseModel(
      token: json['token'] as String,
      message: json['message'] as String,
      success: json['success'] as bool,
    );

Map<String, dynamic> _$VerifyEmailResponseModelToJson(
        VerifyEmailResponseModel instance) =>
    <String, dynamic>{
      'token': instance.token,
      'message': instance.message,
      'success': instance.success,
    };
