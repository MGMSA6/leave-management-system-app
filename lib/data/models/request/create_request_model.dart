import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../response/decided_by_model.dart';

part 'create_request_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class CreateRequestModel extends Equatable {
  final String requestType;
  final String fromDate;
  final String toDate;
  final String reason;
  final int decidedBy;

  const CreateRequestModel(
      {required this.requestType,
      required this.fromDate,
      required this.toDate,
      required this.reason,
      required this.decidedBy});

  factory CreateRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CreateRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateRequestModelToJson(this);

  @override
  List<Object?> get props => [
        requestType,
        fromDate,
        toDate,
        reason,
        decidedBy,
      ];
}
