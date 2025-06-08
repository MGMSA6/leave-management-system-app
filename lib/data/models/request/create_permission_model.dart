import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_permission_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CreatePermissionModel extends Equatable {
  final int managerId;
  final String startTime;
  final String endTime;
  final String reason;

  const CreatePermissionModel({
    required this.managerId,
    required this.startTime,
    required this.endTime,
    required this.reason,
  });

  factory CreatePermissionModel.fromJson(Map<String, dynamic> json) =>
      _$CreatePermissionModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePermissionModelToJson(this);

  @override
  List<Object?> get props => [managerId, startTime, endTime, reason];
}
