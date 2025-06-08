import 'package:flutter/material.dart';

enum LeaveType {
  sick,
  casual,
  probationary,
  unplanned,
  maternity,
  paternity,
}

extension LeaveTypeExtension on LeaveType {
  String get label {
    switch (this) {
      case LeaveType.sick:
        return 'Sick';
      case LeaveType.casual:
        return 'Casual';
      case LeaveType.probationary:
        return 'Probationary';
      case LeaveType.unplanned:
        return 'Unplanned';
      case LeaveType.maternity:
        return 'Maternity';
      case LeaveType.paternity:
        return 'Paternity';
    }
  }

  IconData get icon {
    switch (this) {
      case LeaveType.sick:
        return Icons.local_hospital;
      case LeaveType.casual:
        return Icons.weekend;
      case LeaveType.probationary:
        return Icons.verified_user;
      case LeaveType.unplanned:
        return Icons.error_outline;
      case LeaveType.maternity:
        return Icons.pregnant_woman;
      case LeaveType.paternity:
        return Icons.family_restroom;
    }
  }

  static LeaveType fromString(String value) {
    return LeaveType.values.firstWhere(
          (type) => type.name.toLowerCase() == value.toLowerCase(),
      orElse: () => LeaveType.casual,
    );
  }
}
