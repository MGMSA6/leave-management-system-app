import 'package:manam_leave_management/data/models/response/get_request_by_id_response_model.dart';

import '../../data/models/response/response_model.dart';
import '../../data/models/response/decided_by_model.dart';

class GetReqByIdEntity {
  final int id;
  final String requestType;
  final String userName;
  final int userId;
  final String fromDate;
  final String toDate;
  final String reason;
  final String? remarks;
  final DecidedByModel decidedBy;
  final String status;
  final int requestedWorkingDays;
  final String createdOn;
  final String updatedOn;

  const GetReqByIdEntity({
    required this.id,
    required this.requestType,
    required this.userName,
    required this.userId,
    required this.fromDate,
    required this.toDate,
    required this.reason,
    required this.remarks,
    required this.decidedBy,
    required this.status,
    required this.requestedWorkingDays,
    required this.createdOn,
    required this.updatedOn,
  });
}

extension GetReqByIdDataModelMapper on ResponseModel {
  GetReqByIdEntity toEntity() {
    return GetReqByIdEntity(
      id: id,
      requestType: requestType,
      userName: userName,
      userId: userId,
      fromDate: fromDate,
      toDate: toDate,
      reason: reason,
      remarks: remarks,
      status: status,
      decidedBy: decidedBy,
      requestedWorkingDays: requestedWorkingDays,
      createdOn: createdOn,
      updatedOn: updatedOn,
    );
  }
}
