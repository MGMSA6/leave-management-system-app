import 'package:dio/dio.dart';
import 'package:manam_leave_management/core/utils/safe_api_call.dart';
import 'package:manam_leave_management/data/models/request/create_permission_model.dart';
import 'package:manam_leave_management/data/models/request/create_request_model.dart';
import 'package:manam_leave_management/data/models/response/base_model.dart';
import 'package:manam_leave_management/data/models/response/permission_response_model.dart';

import '../../../core/errors/exceptions.dart';
import '../../../core/utils/api_constants.dart';

abstract class PermissionDataSource {
  Future<BaseModel<PermissionResponseModel>> createPermission(
      CreatePermissionModel createPermissionModel);
}

class PermissionDataSourceImpl implements PermissionDataSource {
  final Dio dio;

  PermissionDataSourceImpl(this.dio);

  @override
  Future<BaseModel<PermissionResponseModel>> createPermission(
      CreatePermissionModel createPermissionModel) async {
    return SafeApiCall.execute(() async {
      final response = await dio.post(ApiConstants.createPermission,
          data: createPermissionModel);

      print("✅ API Response: ${response.data}");

      return BaseModel<PermissionResponseModel>.fromJson(
          response.data, (data) => PermissionResponseModel.fromJson(data));
    });
  }
}
