part of 'current_user_application_bloc.dart';

abstract class CurrentUserApplicationState extends Equatable {
  const CurrentUserApplicationState();

  @override
  List<Object?> get props => [];
}

class CurrentUserApplicationInitial extends CurrentUserApplicationState {}

class CurrentUserApplicationLoading extends CurrentUserApplicationState {}

class CurrentUserApplicationLoaded extends CurrentUserApplicationState {
  final CurrentUserApplicationEntity data;

  const CurrentUserApplicationLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

class CurrentUserApplicationError extends CurrentUserApplicationState {
  final String message;

  const CurrentUserApplicationError(this.message);

  @override
  List<Object?> get props => [message];
}
