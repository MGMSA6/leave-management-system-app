import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manam_leave_management/core/utils/app_validators.dart';
import 'package:manam_leave_management/core/utils/date_validator.dart';

import '../../../domain/usecases/create_permission_usecase.dart';
import 'new_permission_event.dart';
import 'new_permission_state.dart';

class NewPermissionBloc extends Bloc<NewPermissionEvent, NewPermissionState> {
  final CreatePermissionUseCase createPermissionUseCase;

  NewPermissionBloc(this.createPermissionUseCase)
      : super(NewPermissionInitial()) {
    on<InitializeNewPermission>((_, emit) => emit(NewPermissionInitial()));

    on<EnterPermissionReason>((event, emit) {
      emit(state.copyWith(reason: event.reason));
    });

    on<SelectFromDate>((e, emit) {
      final days = DateValidator.daysBetween(e.date, state.toDate);
      emit(state.copyWith(fromDate: e.date, duration: days));
    });

    on<SelectToDate>((e, emit) {
      final days = DateValidator.daysBetween(state.fromDate, e.date);
      emit(state.copyWith(toDate: e.date, duration: days));
    });

    on<SelectFromTime>((event, emit) {
      final newFromTime = event.fromTime;
      final totalTime = AppValidators.calculateTotalTimeWithValidation(
        newFromTime,
        state.toTime,
      );

      if (totalTime != null) {
        emit(state.copyWith(
          fromTime: newFromTime,
          totalTime: totalTime,
        ));
      }
    });

    on<SelectToTime>((event, emit) {
      final newToTime = event.toTime;
      final totalTime = AppValidators.calculateTotalTimeWithValidation(
        state.fromTime,
        newToTime,
      );

      if (totalTime != null) {
        emit(state.copyWith(
          toTime: newToTime,
          totalTime: totalTime,
        ));
      }
    });

    on<SelectManagement>((event, emit) {
      emit(state.copyWith(managers: event.managers));
    });

    on<SubmitPermission>((event, emit) async {
      emit(state.copyWith(status: NewPermissionStatus.submitting));
      final result =
          await createPermissionUseCase.call(event.createPermissionModel);
      result.fold(
        (fail) {
          emit(state.copyWith(
            status: NewPermissionStatus.failure,
            errorMessage: fail.message,
          ));
        },
        (data) {
          emit(state.copyWith(status: NewPermissionStatus.success));
        },
      );
    });
  }
}
