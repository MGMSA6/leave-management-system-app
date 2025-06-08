import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:manam_leave_management/data/models/response/permission_response_model.dart';
import 'package:manam_leave_management/data/models/response/response_model.dart';

part 'all_response_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class AllResponseModel extends Equatable {
  final Map<String, List<ResponseModel>> wfh;
  final Map<String, List<ResponseModel>> leave;
  final Map<String, List<PermissionResponseModel>> permission;

  const AllResponseModel({
    required this.wfh,
    required this.leave,
    required this.permission,
  });

  factory AllResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AllResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AllResponseModelToJson(this);

  @override
  List<Object?> get props => [wfh, leave, permission];
}
