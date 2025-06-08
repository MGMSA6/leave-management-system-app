import 'package:equatable/equatable.dart';
import '../../../core/utils/date_validator.dart';
import '../../../core/utils/leave_type.dart';
import '../../../core/utils/session_manager.dart';
import '../../../data/models/leave_matrices.dart';

enum NewRequestStatus {
  create,
  edit,
  initial,
  submitting,
  success,
  failure,
  delete
}

class NewRequestState extends Equatable {
  final NewRequestStatus status;
  final String? errorMessage;

  // your form fields
  final String requestType;
  final String reason;
  final DateTime fromDate;
  final DateTime toDate;
  final List<String> managers;
  final int? duration;

  const NewRequestState({
    this.status = NewRequestStatus.initial,
    this.errorMessage,
    required this.requestType,
    required this.reason,
    required this.fromDate,
    required this.toDate,
    required this.managers,
    required this.duration,
  });

  factory NewRequestState.initial() {
    final now = DateTime.now();
    final defaultManagers = SessionManager()
            .user
            ?.superiors
            .map((s) => s.name)
            .toList() ??
        [];
    return NewRequestState(
      requestType: LeaveType.casual.label,
      reason: 'Family Vacation',
      fromDate: now,
      toDate: now.add(const Duration(days: 1)),
      managers: defaultManagers,
      duration: 1,
    );
  }

  NewRequestState copyWith({
    NewRequestStatus? status,
    String? errorMessage,
    String? requestType,
    String? reason,
    DateTime? fromDate,
    DateTime? toDate,
    List<String>? managers,
    int? duration,
  }) {
    return NewRequestState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      requestType: requestType ?? this.requestType,
      reason: reason ?? this.reason,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      managers: managers ?? this.managers,
      duration: duration ?? this.duration,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        requestType,
        reason,
        fromDate,
        toDate,
        managers,
        duration,
      ];
}
