import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/app_strings.dart';
import '../../../core/utils/session_manager.dart';

enum NewPermissionStatus { create, edit, initial, submitting, success, failure }

class NewPermissionState {
  final NewPermissionStatus status;
  final String? errorMessage;

  final String reason;
  final DateTime fromTime;
  final DateTime fromDate;
  final DateTime toDate;
  final DateTime toTime;
  final List<String> managers;
  final double? totalTime;
  final int? duration;


  const NewPermissionState({
    required this.reason,
    required this.fromTime,
    required this.fromDate,
    required this.toDate,
    required this.toTime,
    required this.duration,
    required this.managers,
    required this.totalTime,
    this.status = NewPermissionStatus.initial,
    this.errorMessage,
  });

  NewPermissionState copyWith({
    String? reason,
    DateTime? fromTime,
    DateTime? toTime,
    DateTime? fromDate,
    DateTime? toDate,
    double? totalTime,
    List<String>? managers,
    NewPermissionStatus? status,
    String? errorMessage,
    int? duration,
  }) {
    return NewPermissionState(
      reason: reason ?? this.reason,
      fromTime: fromTime ?? this.fromTime,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      toTime: toTime ?? this.toTime,
      managers: managers ?? this.managers,
      totalTime: totalTime ?? this.totalTime,
      duration: duration ?? this.duration,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class NewPermissionInitial extends NewPermissionState {
  static final defaultManagers = SessionManager()
          .user
          ?.superiors
          .map((s) => s.name.split(' ').first)
          .toList() ??
      [];

  NewPermissionInitial()
      : super(
          reason: AppStrings.familyTrip,
          fromTime: DateTime.now(),
          fromDate: DateTime.now(),
          toDate: DateTime.now().add(const Duration(days: 1)),
          toTime: DateTime.now().add(const Duration(hours: 1)),
          managers: defaultManagers,
          duration: 1,
          totalTime: 1,
        );
}
