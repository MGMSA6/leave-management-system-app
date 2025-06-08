import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'holiday_model.g.dart';

@JsonSerializable(explicitToJson: true)
class HolidayModel extends Equatable {
  final int id;
  final String holidayName;
  final String holidayDate;

  const HolidayModel({
    required this.id,
    required this.holidayName,
    required this.holidayDate,
  });

  factory HolidayModel.fromJson(Map<String, dynamic> json) =>
      _$HolidayModelFromJson(json);

  Map<String, dynamic> toJson() => _$HolidayModelToJson(this);

  @override
  List<Object?> get props => [id, holidayName, holidayDate];
}
