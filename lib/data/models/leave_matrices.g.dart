// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_matrices.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveMatrices _$LeaveMatricesFromJson(Map<String, dynamic> json) =>
    LeaveMatrices(
      leaveBalance: json['leaveBalance'] as String,
      allocated: (json['allocated'] as num).toInt(),
      used: (json['used'] as num).toInt(),
      pending: (json['pending'] as num).toInt(),
      percentage: json['percentage'] as String,
    );

Map<String, dynamic> _$LeaveMatricesToJson(LeaveMatrices instance) =>
    <String, dynamic>{
      'leaveBalance': instance.leaveBalance,
      'allocated': instance.allocated,
      'used': instance.used,
      'pending': instance.pending,
      'percentage': instance.percentage,
    };
