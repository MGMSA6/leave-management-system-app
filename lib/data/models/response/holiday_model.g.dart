// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'holiday_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HolidayModel _$HolidayModelFromJson(Map<String, dynamic> json) => HolidayModel(
      id: (json['id'] as num).toInt(),
      holidayName: json['holidayName'] as String,
      holidayDate: json['holidayDate'] as String,
    );

Map<String, dynamic> _$HolidayModelToJson(HolidayModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'holidayName': instance.holidayName,
      'holidayDate': instance.holidayDate,
    };
