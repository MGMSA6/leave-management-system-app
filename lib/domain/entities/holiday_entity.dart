import 'package:manam_leave_management/data/models/response/holiday_model.dart';

class HolidayEntity {
  final int id;
  final String holidayName;
  final String holidayDate;

  HolidayEntity({
    required this.id,
    required this.holidayName,
    required this.holidayDate,
  });
}

extension HolidayEntityMapper on HolidayModel {
  HolidayEntity toEntity() {
    return HolidayEntity(
      id: id,
      holidayName: holidayName,
      holidayDate: holidayDate,
    );
  }
}
