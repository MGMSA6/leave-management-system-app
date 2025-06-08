import 'package:flutter/material.dart';

enum StatusType {
  pending,
  approved,
  rejected,
}

extension LeaveTypeExtension on StatusType {
  String get label {
    switch (this) {
      case StatusType.pending:
        return 'Pending';
      case StatusType.approved:
        return 'Approved';
      case StatusType.rejected:
        return 'Rejected';
    }
  }

  static StatusType fromString(String value) {
    return StatusType.values.firstWhere(
      (type) => type.name.toLowerCase() == value.toLowerCase(),
      orElse: () => StatusType.pending,
    );
  }
}
