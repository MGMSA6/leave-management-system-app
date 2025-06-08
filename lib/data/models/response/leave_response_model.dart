import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'decided_by_model.dart';

part 'leave_response_model.g.dart';

@JsonSerializable()
class LeaveResponseModel extends Equatable {
  final int id;
  final String requestType;
  final String userName;
  final String fromDate;
  final String toDate;
  final String reason;
  final String? remarks;
  final String status;
  final DecidedByModel decidedBy;
  final int requestedWorkingDays;
  final String createdOn;
  final String updatedOn;

  const LeaveResponseModel({
    required this.id,
    required this.requestType,
    required this.userName,
    required this.fromDate,
    required this.toDate,
    required this.reason,
    this.remarks,
    required this.status,
    required this.decidedBy,
    required this.requestedWorkingDays,
    required this.createdOn,
    required this.updatedOn,
  });

  factory LeaveResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LeaveResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveResponseModelToJson(this);

  @override
  List<Object?> get props => [
    id,
    requestType,
    userName,
    fromDate,
    toDate,
    reason,
    remarks,
    status,
    decidedBy,
    requestedWorkingDays,
    createdOn,
    updatedOn,
  ];
}
