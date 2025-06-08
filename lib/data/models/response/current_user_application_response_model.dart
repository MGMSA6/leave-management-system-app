import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:manam_leave_management/data/models/response/response_model.dart';
import 'permission_response_model.dart';

part 'current_user_application_response_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class CurrentUserApplicationResponseModel extends Equatable {
  final Map<String, List<ResponseModel>> wfh;
  final Map<String, List<ResponseModel>> leave;
  final Map<String, List<PermissionResponseModel>> permission;

  const CurrentUserApplicationResponseModel({
    required this.wfh,
    required this.leave,
    required this.permission,
  });

  factory CurrentUserApplicationResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$CurrentUserApplicationResponseModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CurrentUserApplicationResponseModelToJson(this);

  @override
  List<Object?> get props => [
        wfh,
        leave,
        permission,
      ];
}
