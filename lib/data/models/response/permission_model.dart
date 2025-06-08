class PermissionModel {
  final int? id;
  final int? duration;
  final DateTime fromTime;
  final DateTime toTime;
  final String reason;
  final String status;
  final bool isEdit;
  final List<String> managers;

  PermissionModel({
    required this.id,
    required this.duration,
    required this.fromTime,
    required this.toTime,
    required this.reason,
    required this.status,
    required this.isEdit,
    required this.managers,
  });
}
