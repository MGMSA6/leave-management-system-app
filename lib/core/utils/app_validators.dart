import 'package:flutter/material.dart';
import 'package:manam_leave_management/core/utils/session_manager.dart';
import 'package:manam_leave_management/core/utils/toast_helper.dart';

import '../../domain/entities/login_entity.dart';

class AppValidators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email cannot be empty";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.length < 6) {
      return "Password must be at least 6 characters long";
    }
    return null;
  }

  static double? calculateTotalTimeWithValidation(
    DateTime fromTime,
    DateTime toTime,
  ) {
    final diffMinutes = toTime.difference(fromTime).inMinutes;

    if (diffMinutes < 60) {
      ToastHelper.showToast("Please select a duration of at least 1 hour");
      return null;
    }

    // Convert minutes to hours
    return diffMinutes / 60.0;
  }

  static String formatLeaveType(String leaveType) {
    switch (leaveType) {
      case 'SICK_LEAVE':
        return 'Sick';
      case 'CASUAL_LEAVE':
        return 'Casual';
      case 'WFH':
        return 'WFH';
      case 'UNPLANNED_LEAVE':
        return 'Unplanned Leave';
      default:
        return leaveType
            .replaceAll('_', ' ')
            .toUpperCase(); // Default formatting, in case new types are added
    }
  }

  static String getInitial() {
    LoginEntity? user = SessionManager().user;
    final fullName = (user?.name ?? '').trim();
    final firstName = fullName.split(' ').first;
    final initial = firstName.isNotEmpty ? firstName[0].toUpperCase() : 'U';
    return initial;
  }
}
