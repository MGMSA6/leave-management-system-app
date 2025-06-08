import 'package:dio/dio.dart';
import 'package:manam_leave_management/core/utils/api_constants.dart';
import 'package:manam_leave_management/core/utils/safe_api_call.dart';
import 'package:manam_leave_management/data/models/response/base_model.dart';
import 'package:manam_leave_management/data/models/response/current_user_application_response_model.dart';

import '../../../core/errors/exceptions.dart';
import '../../models/request/all_response_model.dart';
import '../../models/response/response_model.dart';

abstract class CurrentUserApplicationsRemoteDataSource {
  Future<BaseModel<CurrentUserApplicationResponseModel>>
      getCurrentUserApplicationData();
}

class CurrentUserApplicationsRemoteDatasourceImpl
    implements CurrentUserApplicationsRemoteDataSource {
  final Dio dio;

  CurrentUserApplicationsRemoteDatasourceImpl(this.dio);

  @override
  Future<BaseModel<CurrentUserApplicationResponseModel>>
      getCurrentUserApplicationData() async {
    return SafeApiCall.execute(() async {
      final response = await dio.get(ApiConstants.getApplicationsOfCurrentUser);

      print("✅ API Response: ${response.data}");

      return BaseModel<CurrentUserApplicationResponseModel>.fromJson(
        response.data,
        (data) => CurrentUserApplicationResponseModel.fromJson(data),
      );
    });
  }
}
