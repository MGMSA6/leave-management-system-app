// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BalanceModel _$BalanceModelFromJson(Map<String, dynamic> json) => BalanceModel(
      balanceType: json['balanceType'] as String,
      allocated: (json['allocated'] as num).toInt(),
      used: (json['used'] as num).toInt(),
      pending: (json['pending'] as num).toInt(),
    );

Map<String, dynamic> _$BalanceModelToJson(BalanceModel instance) =>
    <String, dynamic>{
      'balanceType': instance.balanceType,
      'allocated': instance.allocated,
      'used': instance.used,
      'pending': instance.pending,
    };
