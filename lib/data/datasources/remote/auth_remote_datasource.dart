import 'package:dio/dio.dart';
import 'package:manam_leave_management/core/utils/api_constants.dart';

import '../../../core/errors/exceptions.dart';
import '../../../core/utils/safe_api_call.dart';
import '../../models/response/base_model.dart';
import '../../models/response/login_data_model.dart';

abstract class AuthRemoteDataSource {
  Future<BaseModel<LoginDataModel>> login(String loginId, String password);
}

class AuthRemoteDatasourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDatasourceImpl(this.dio);

  @override
  Future<BaseModel<LoginDataModel>> login(
      String loginId, String password) async {
    return SafeApiCall.execute(() async {
      final response = await dio.post(
        ApiConstants.login,
        data: {
          "loginId": loginId,
          "password": password,
        },
      );
      print("✅ API Response: ${response.data}");
      return BaseModel<LoginDataModel>.fromJson(
        response.data,
        (data) => LoginDataModel.fromJson(data),
      );
    });
  }
}
