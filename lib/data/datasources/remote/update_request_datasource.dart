import 'package:dio/dio.dart';
import 'package:manam_leave_management/core/utils/api_constants.dart';
import 'package:manam_leave_management/core/utils/safe_api_call.dart';
import 'package:manam_leave_management/data/models/request/create_request_model.dart';
import 'package:manam_leave_management/data/models/response/base_model.dart';

import '../../../core/errors/exceptions.dart';
import '../../models/response/response_model.dart';

abstract class UpdateRequestDatasource {
  Future<BaseModel<ResponseModel>> updateRequest(
      String id, CreateRequestModel createRequestModel);
}

class UpdateRequestDatasourceImpl implements UpdateRequestDatasource {
  final Dio dio;

  UpdateRequestDatasourceImpl(this.dio);

  @override
  Future<BaseModel<ResponseModel>> updateRequest(
      String id, CreateRequestModel createRequestModel) async {
    return SafeApiCall.execute(() async {
      final response = await dio.put("${ApiConstants.createRequest}/$id",
          data: createRequestModel.toJson());

      print("✅ API Response: ${response.data}");

      return BaseModel<ResponseModel>.fromJson(
        response.data,
        (data) => ResponseModel.fromJson(data),
      );
    });
  }
}
