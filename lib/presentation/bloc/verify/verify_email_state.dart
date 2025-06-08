part of 'verify_email_bloc.dart';

abstract class VerifyEmailState extends Equatable {
  const VerifyEmailState();

  @override
  List<Object> get props => [];
}

class VerifyEmailInitial extends VerifyEmailState {}


final class VerifyEmailLoading extends VerifyEmailState {}

final class VerifyEmailSuccess extends VerifyEmailState {
  final VerifyEmailEntity verifyEmailEntity;

  const VerifyEmailSuccess(this.verifyEmailEntity);

  @override
  List<Object> get props => [verifyEmailEntity];
}

final class VerifyEmailFailure extends VerifyEmailState {
  final String error;

  const VerifyEmailFailure(this.error);

  @override
  List<Object> get props => [error];
}
