class LeaveModel {
  final int? id;
  final int? duration;
  final DateTime fromDate;
  final DateTime toDate;
  final String reason;
  final String status;
  final String leaveType;
  final bool isEdit;
  final List<String> managers;

  LeaveModel({
    required this.id,
    required this.duration,
    required this.fromDate,
    required this.toDate,
    required this.reason,
    required this.status,
    required this.leaveType,
    required this.isEdit,
    required this.managers,
  });
}
