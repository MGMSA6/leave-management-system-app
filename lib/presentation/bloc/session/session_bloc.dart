import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:manam_leave_management/core/utils/leave_type.dart';
import 'package:meta/meta.dart';

import '../../../core/utils/common_service.dart';
import '../../../data/models/leave_matrices.dart';

part 'session_event.dart';

part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  SessionBloc()
      : super(SessionState(
    // initialize with Casual request for example
    leaveMatrices: CommonService.getBalanceModel(LeaveType.casual.label),
  )) {
    on<GetLeaveBalanceEvent>((event, emit) {
      final updated = CommonService.getBalanceModel(event.leaveType);
      emit(SessionState(leaveMatrices: updated));
    });
  }
}
