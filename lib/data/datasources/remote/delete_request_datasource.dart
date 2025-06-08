import 'package:dio/dio.dart';
import 'package:manam_leave_management/core/utils/api_constants.dart';
import 'package:manam_leave_management/core/utils/safe_api_call.dart';
import 'package:manam_leave_management/data/models/response/base_model.dart';

abstract class DeleteRequestDataSource {
  Future<BaseModel> deleteRequest(String id);
}

class DeleteRequestDataSourceImpl extends DeleteRequestDataSource {
  final Dio dio;

  DeleteRequestDataSourceImpl(this.dio);

  @override
  Future<BaseModel> deleteRequest(String id) async {
    return SafeApiCall.execute(() async {
      final response = await dio.delete("${ApiConstants.createRequest}/$id");
      return BaseModel.fromJson(response.data, (json) => json);
    });
  }
}
