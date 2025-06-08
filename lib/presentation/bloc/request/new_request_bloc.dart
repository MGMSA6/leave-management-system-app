import 'package:bloc/bloc.dart';
import 'package:manam_leave_management/core/utils/common_service.dart';
import 'package:manam_leave_management/domain/usecases/update_request_usecase.dart';
import '../../../core/utils/date_validator.dart';
import '../../../core/utils/session_manager.dart';
import '../../../domain/usecases/create_request_usecase.dart';
import '../../../domain/usecases/delete_request_usecase.dart';
import 'new_request_event.dart';
import 'new_request_state.dart';

class NewRequestBloc extends Bloc<NewRequestEvent, NewRequestState> {
  final CreateRequestUseCase createRequestUseCase;
  final DeleteRequestUseCase deleteRequestUseCase;
  final UpdateRequestUseCase updateRequestUseCase;

  NewRequestBloc(this.createRequestUseCase, this.deleteRequestUseCase,
      this.updateRequestUseCase)
      : super(NewRequestState.initial()) {
    on<InitializeNewRequest>((_, emit) => emit(NewRequestState.initial()));

    on<SelectFromDate>((e, emit) {
      final days = DateValidator.daysBetween(e.date, state.toDate);
      emit(state.copyWith(fromDate: e.date, duration: days));
    });

    on<SelectToDate>((e, emit) {
      final days = DateValidator.daysBetween(state.fromDate, e.date);
      emit(state.copyWith(toDate: e.date, duration: days));
    });

    on<EnterRequestReason>((e, emit) => emit(state.copyWith(reason: e.reason)));

    on<SelectRequestType>(
        (e, emit) => emit(state.copyWith(requestType: e.requestType)));

    on<SelectManager>((e, emit) => emit(state.copyWith(managers: e.managers)));

    on<LoadRequestForEdit>((event, emit) {
      emit(NewRequestState(
        status: NewRequestStatus.edit,
        requestType: event.leave.leaveType,
        reason: event.leave.reason,
        fromDate: event.leave.fromDate,
        toDate: event.leave.toDate,
        managers: List.from(event.leave.managers),
        duration: event.leave.duration,
      ));
    });

    on<SubmitRequest>((e, emit) async {
      emit(state.copyWith(status: NewRequestStatus.submitting));
      final result = await createRequestUseCase.call(e.createRequestModel);
      result.fold(
        (fail) {
          emit(state.copyWith(
            status: NewRequestStatus.failure,
            errorMessage: fail.message,
          ));
        },
        (data) {
          emit(state.copyWith(status: NewRequestStatus.success));
        },
      );
    });

    on<UpdateRequest>((e, emit) async {
      emit(state.copyWith(status: NewRequestStatus.submitting));
      final result =
          await updateRequestUseCase.call(e.id, e.createRequestModel);
      result.fold(
        (fail) {
          emit(state.copyWith(
            status: NewRequestStatus.failure,
            errorMessage: fail.message,
          ));
        },
        (data) {
          emit(state.copyWith(status: NewRequestStatus.success));
        },
      );
    });

    on<DeleteRequest>((e, emit) async {
      emit(state.copyWith(status: NewRequestStatus.submitting));

      final result = await deleteRequestUseCase.call(e.id);
      result.fold((fail) {
        emit(state.copyWith(
          status: NewRequestStatus.failure,
          errorMessage: fail.message,
        ));
      }, (data) {
        emit(state.copyWith(status: NewRequestStatus.delete));
      });
    });
  }
}
