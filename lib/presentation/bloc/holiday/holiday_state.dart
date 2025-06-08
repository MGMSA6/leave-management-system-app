part of 'holiday_bloc.dart';

abstract class HolidayState extends Equatable {
  const HolidayState();

  @override
  List<Object?> get props => [];
}

final class HolidayInitial extends HolidayState {}

final class HolidayLoading extends HolidayState {}

final class HolidaySuccess extends HolidayState {

  final List<HolidayEntity> data;

  const HolidaySuccess(this.data);

  @override
  List<Object?> get props => [data];

}

final class HolidayInitialFailure extends HolidayState {
  final String message;

  const HolidayInitialFailure(this.message);

  @override
  List<Object?> get props => [message];

}
