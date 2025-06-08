import 'package:manam_leave_management/data/models/response/holiday_model.dart';
import 'package:manam_leave_management/data/models/response/verify_email_response_model.dart';

class VerifyEmailEntity {
  final String token;
  final String message;
  final bool success;

  VerifyEmailEntity({
    required this.token,
    required this.message,
    required this.success,
  });
}

extension HolidayEntityMapper on VerifyEmailResponseModel {
  VerifyEmailEntity toEntity() {
    return VerifyEmailEntity(
      token: token,
      message: message,
      success: success,
    );
  }
}
