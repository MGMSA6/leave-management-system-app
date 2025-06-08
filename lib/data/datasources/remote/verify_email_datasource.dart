import 'package:dio/dio.dart';
import 'package:manam_leave_management/core/utils/safe_api_call.dart';
import 'package:manam_leave_management/data/models/response/verify_email_response_model.dart';

import '../../../core/utils/api_constants.dart';
import '../../models/response/base_model.dart';

abstract class VerifyEmailDataSource {
  Future<BaseModel<VerifyEmailResponseModel>> verifyEmail(String email);
}

class VerifyEmailDataSourceImpl implements VerifyEmailDataSource {
  final Dio dio;

  VerifyEmailDataSourceImpl(this.dio);

  @override
  Future<BaseModel<VerifyEmailResponseModel>> verifyEmail(String email) async {
    return SafeApiCall.execute(() async {
      final response = await dio.post(
        ApiConstants.verifyEmail,
        data: {
          "email": email,
        },
      );
      print("✅ API Response: ${response.data}");
      return BaseModel<VerifyEmailResponseModel>.fromJson(
        response.data,
        (data) => VerifyEmailResponseModel.fromJson(data),
      );
    });
  }
}
