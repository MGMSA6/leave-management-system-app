import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'permission_response_model.g.dart';


@JsonSerializable(explicitToJson: true)
class PermissionResponseModel extends Equatable {
  final int id;
  final int employeeId;
  final String employeeName;
  final int managerId;
  final String managerName;
  final String startTime;
  final String endTime;
  final int durationMinutes;
  final String reason;
  final String status;
  final String createdOn;
  final String updatedOn;

  const PermissionResponseModel({
    required this.id,
    required this.employeeId,
    required this.employeeName,
    required this.managerId,
    required this.managerName,
    required this.startTime,
    required this.endTime,
    required this.durationMinutes,
    required this.reason,
    required this.status,
    required this.createdOn,
    required this.updatedOn,
  });

  factory PermissionResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PermissionResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$PermissionResponseModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        employeeId,
        employeeName,
        managerId,
        managerName,
        startTime,
        endTime,
        durationMinutes,
        reason,
        status,
        createdOn,
        updatedOn,
      ];
}
