// balance_model.dart
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'leave_matrices.g.dart';

@JsonSerializable(explicitToJson: true)
class LeaveMatrices extends Equatable {
  final String leaveBalance;
  final int allocated;
  final int used;
  final int pending;
  final String percentage;

  const LeaveMatrices({
    required this.leaveBalance,
    required this.allocated,
    required this.used,
    required this.pending,
    required this.percentage,
  });

  factory LeaveMatrices.fromJson(Map<String, dynamic> json) =>
      _$LeaveMatricesFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveMatricesToJson(this);

  @override
  List<Object?> get props =>
      [allocated, used, pending, leaveBalance, percentage];
}
