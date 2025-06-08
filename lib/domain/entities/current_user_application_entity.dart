import 'package:manam_leave_management/data/models/response/permission_response_model.dart';
import 'package:manam_leave_management/data/models/response/current_user_application_response_model.dart';

import '../../data/models/response/response_model.dart';

class CurrentUserApplicationEntity {
  final Map<String, List<ResponseModel>> wfh;
  final Map<String, List<ResponseModel>> leave;
  final Map<String, List<PermissionResponseModel>> permission;

  const CurrentUserApplicationEntity({
    required this.wfh,
    required this.leave,
    required this.permission,
  });
}

extension CurrentUserApplicationEntityMapper
    on CurrentUserApplicationResponseModel {
  CurrentUserApplicationEntity toEntity() {
    return CurrentUserApplicationEntity(
      wfh: wfh,
      leave: leave,
      permission: permission,
    );
  }
}
