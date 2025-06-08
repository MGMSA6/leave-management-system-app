part of 'verify_email_bloc.dart';

abstract class VerifyEmailEvent extends Equatable {
  const VerifyEmailEvent();

  @override
  List<Object?> get props => [];
}

class VerifyEmailSubmitted extends VerifyEmailEvent {
  final String email;

  const VerifyEmailSubmitted({required this.email});

  @override
  List<Object?> get props => [email];
}
