import 'package:dio/dio.dart';

import '../errors/exceptions.dart';

class SafeApiCall {
  static Future<T> execute<T>(Future<T> Function() apiCall) async {
    try {
      return await apiCall();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw NetworkException();
      } else if (e.response?.statusCode == 401) {
        throw UnauthorizedException();
      } else if (e.response != null) {
        throw ServerException(
            "Server error: ${e.response?.data['statusDesc'] ?? 'Unknown error'}");
      } else {
        throw ServerException("Unexpected Dio error: ${e.message}");
      }
    } catch (e) {
      print("❌ JSON Parse or Unknown Error: $e");
      throw UnexpectedException("Unexpected error: $e");
    }
  }
}
