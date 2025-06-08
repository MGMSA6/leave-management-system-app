import 'package:dio/dio.dart';
import 'package:manam_leave_management/core/utils/api_constants.dart';
import 'package:manam_leave_management/core/utils/safe_api_call.dart';
import 'package:manam_leave_management/data/models/response/get_request_by_id_response_model.dart';

import '../../../core/errors/exceptions.dart';

abstract class GetReqByIdDatasource {
  Future<GetRequestByIdResponseModel> getReqById(String userId);
}

class GetReqByIdDatasourceImpl implements GetReqByIdDatasource {
  final Dio dio;

  GetReqByIdDatasourceImpl(this.dio);

  @override
  Future<GetRequestByIdResponseModel> getReqById(String userId) async {
    return SafeApiCall.execute(() async {
      final response = await dio.get(ApiConstants.getUserById + userId);

      print("✅ API Response: ${response.data}");

      return GetRequestByIdResponseModel.fromJson(response.data);
    });
  }
}
