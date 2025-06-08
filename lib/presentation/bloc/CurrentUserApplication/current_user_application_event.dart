part of 'current_user_application_bloc.dart';

abstract class CurrentUserApplicationEvent extends Equatable {
  const CurrentUserApplicationEvent();

  @override
  List<Object?> get props => [];
}

class FetchCurrentUserApplications extends CurrentUserApplicationEvent {}
