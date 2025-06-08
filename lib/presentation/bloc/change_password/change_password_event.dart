part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object?> get props => [];
}

class ChangePasswordSubmitted extends ChangePasswordEvent {
  final String newPassword;
  final String confirmPassword;

  const ChangePasswordSubmitted(
      {required this.newPassword, required this.confirmPassword});

  @override
  List<Object?> get props => [newPassword, confirmPassword];
}
