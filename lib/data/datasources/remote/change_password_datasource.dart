import 'package:dio/dio.dart';
import 'package:manam_leave_management/core/utils/api_constants.dart';

import '../../../core/errors/exceptions.dart';
import '../../../core/utils/safe_api_call.dart';
import '../../models/response/base_model.dart';
import '../../models/response/login_data_model.dart';

abstract class ChangePasswordDatasource {
  Future<BaseModel> changePassword(String newPassword, String confirmPassword);
}

class ChangePasswordDatasourceImpl implements ChangePasswordDatasource {
  final Dio dio;

  ChangePasswordDatasourceImpl(this.dio);

  @override
  Future<BaseModel> changePassword(
      String newPassword, String confirmPassword) async {
    return SafeApiCall.execute(() async {
      final response = await dio.post(
        ApiConstants.changePassword,
        data: {
          "newPassword": newPassword,
          "confirmPassword": confirmPassword,
        },
      );
      print("✅ API Response: ${response.data}");
      return BaseModel.fromJson(
        response.data,
        (data) => data,
      );
    });
  }
}
