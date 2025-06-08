import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:manam_leave_management/data/models/request/create_permission_model.dart';

abstract class NewPermissionEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitializeNewPermission extends NewPermissionEvent {}

class EnterPermissionReason extends NewPermissionEvent {
  final String reason;

  EnterPermissionReason(this.reason);

  @override
  List<Object?> get props => [reason];
}

class SelectFromDate extends NewPermissionEvent {
  final DateTime date;

  SelectFromDate(this.date);

  @override
  List<Object?> get props => [date];
}

class SelectToDate extends NewPermissionEvent {
  final DateTime date;

  SelectToDate(this.date);

  @override
  List<Object?> get props => [date];
}

class SelectFromTime extends NewPermissionEvent {
  final DateTime fromTime;

  SelectFromTime(this.fromTime);

  @override
  List<Object?> get props => [fromTime];
}

class SelectToTime extends NewPermissionEvent {
  final DateTime toTime;

  SelectToTime(this.toTime);

  @override
  List<Object?> get props => [toTime];
}

class SelectManagement extends NewPermissionEvent {
  final List<String> managers;

  SelectManagement(this.managers);

  @override
  List<Object?> get props => [managers];
}

class SubmitPermission extends NewPermissionEvent {
  final CreatePermissionModel createPermissionModel;

  SubmitPermission({required this.createPermissionModel});

  @override
  List<Object?> get props => [createPermissionModel];
}
