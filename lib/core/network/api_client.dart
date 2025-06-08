import 'package:dio/dio.dart';
import 'package:manam_leave_management/core/network/auth_interceptor.dart';

import '../utils/api_constants.dart';

class ApiClient {
  final Dio dio;

  ApiClient()
      : dio = Dio(BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        )) {
    dio.interceptors.addAll([
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        error: true,
      ),
      AuthInterceptor()
    ]);
  }

  Dio get instance => dio;
}
