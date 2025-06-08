import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:manam_leave_management/core/utils/session_manager.dart';
import 'package:manam_leave_management/domain/usecases/holiday_usecase.dart';

import '../../../domain/entities/holiday_entity.dart';

part 'holiday_event.dart';

part 'holiday_state.dart';

class HolidayBloc extends Bloc<HolidayEvent, HolidayState> {
  final HolidayUseCase holidayUseCase;

  HolidayBloc(this.holidayUseCase ) : super(HolidayInitial()) {
    on<FetchAllHoliday>((event, emit) async {
      emit(HolidayLoading());

      final result = await holidayUseCase.call();

      result.fold(
        (failure) => emit(HolidayInitialFailure(failure.message)),
        (data) {
          SessionManager().setHoliday(data);
          emit(HolidaySuccess(data));
        },
      );
    });
  }
}
