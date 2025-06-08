import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/verify_email_entity.dart';
import '../../../domain/usecases/verify_email_usecase.dart';

part 'verify_email_event.dart';

part 'verify_email_state.dart';

class VerifyEmailBloc extends Bloc<VerifyEmailEvent, VerifyEmailState> {
  final VerifyEmailUseCase verifyEmailUseCase;

  VerifyEmailBloc(this.verifyEmailUseCase) : super(VerifyEmailInitial()) {
    on<VerifyEmailSubmitted>((event, emit) async {
      emit(VerifyEmailLoading());

      final result = await verifyEmailUseCase(event.email);

      result.fold(
        (failure) => emit(VerifyEmailFailure(failure.message)),
        (verifyEmailEntity) => emit(VerifyEmailSuccess(verifyEmailEntity)),
      );
    });
  }
}
