part of 'session_bloc.dart';

@immutable
class SessionState extends Equatable {
  final LeaveMatrices leaveMatrices;

  const SessionState({required this.leaveMatrices});

  @override
  List<Object?> get props => [leaveMatrices];
}
