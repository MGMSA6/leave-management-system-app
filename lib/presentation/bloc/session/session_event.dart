part of 'session_bloc.dart';

@immutable
sealed class SessionEvent extends Equatable {}

class GetLeaveBalanceEvent extends SessionEvent {
  final String leaveType;


  GetLeaveBalanceEvent({required this.leaveType});

  @override
  List<Object?> get props => [leaveType];
}
