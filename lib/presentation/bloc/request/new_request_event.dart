import 'package:equatable/equatable.dart';
import 'package:manam_leave_management/data/models/request/create_request_model.dart';

import '../../../data/models/response/leave_model.dart';

abstract class NewRequestEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitializeNewRequest extends NewRequestEvent {}

class SelectFromDate extends NewRequestEvent {
  final DateTime date;

  SelectFromDate(this.date);

  @override
  List<Object?> get props => [date];
}

class SelectToDate extends NewRequestEvent {
  final DateTime date;

  SelectToDate(this.date);

  @override
  List<Object?> get props => [date];
}

class EnterRequestReason extends NewRequestEvent {
  final String reason;

  EnterRequestReason(this.reason);

  @override
  List<Object?> get props => [reason];
}

class SelectRequestType extends NewRequestEvent {
  final String requestType;

  SelectRequestType(this.requestType);

  @override
  List<Object?> get props => [requestType];
}

class SelectManager extends NewRequestEvent {
  final List<String> managers;

  SelectManager(this.managers);

  @override
  List<Object?> get props => [managers];
}

class LoadRequestForEdit extends NewRequestEvent {
  final LeaveModel leave;

  LoadRequestForEdit(this.leave);

  @override
  List<Object?> get props => [leave];
}

class SubmitRequest extends NewRequestEvent {
  final CreateRequestModel createRequestModel;

  SubmitRequest({required this.createRequestModel});

  @override
  List<Object?> get props => [createRequestModel];
}

class UpdateRequest extends NewRequestEvent {
  final String id;
  final CreateRequestModel createRequestModel;

  UpdateRequest({required this.id, required this.createRequestModel});

  @override
  List<Object?> get props => [id, createRequestModel];
}

class DeleteRequest extends NewRequestEvent {
  final String id;

  DeleteRequest({required this.id});

  @override
  List<Object?> get props => [id];
}
