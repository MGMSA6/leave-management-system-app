import '../../data/models/response/permission_response_model.dart';

class PermissionEntity {
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

  PermissionEntity(
      {required this.id,
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
      required this.updatedOn});
}

extension PermissionEntityMapper on PermissionResponseModel {
  PermissionEntity toEntity() {
    return PermissionEntity(
      id: id,
      employeeId: employeeId,
      employeeName: employeeName,
      managerId: managerId,
      managerName: managerName,
      startTime: startTime,
      endTime: endTime,
      durationMinutes: durationMinutes,
      reason: reason,
      status: status,
      createdOn: createdOn,
      updatedOn: updatedOn,
    );
  }
}
