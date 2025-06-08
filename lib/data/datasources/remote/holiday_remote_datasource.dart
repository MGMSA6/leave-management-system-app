import 'package:dio/dio.dart';
import 'package:manam_leave_management/core/utils/safe_api_call.dart';

import '../../../core/errors/exceptions.dart';
import '../../../core/utils/api_constants.dart';
import '../../models/response/base_model.dart';
import '../../models/response/holiday_model.dart';

abstract class HolidayRemoteDatasource {
  Future<BaseModel<List<HolidayModel>>> getAllHoliday();
}

class HolidayRemoteDatasourceImpl implements HolidayRemoteDatasource {
  final Dio dio;

  HolidayRemoteDatasourceImpl(this.dio);

  @override
  Future<BaseModel<List<HolidayModel>>> getAllHoliday() async {
    return SafeApiCall.execute(() async {
      final response = await dio.get(ApiConstants.getAllHoliday);

      print("✅ API Response: ${response.data}");

      return BaseModel<List<HolidayModel>>.fromJson(
          response.data as Map<String, dynamic>, (rawData) {
        // rawData is List<dynamic>
        final list = rawData as List<dynamic>;
        return list
            .cast<Map<String, dynamic>>()
            .map((e) => HolidayModel.fromJson(e))
            .toList();
      });
    });
  }
}
