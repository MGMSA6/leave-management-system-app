import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/change_password_usecase.dart';

part 'change_password_event.dart';

part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final ChangePasswordUseCase changePasswordUseCase;

  ChangePasswordBloc(this.changePasswordUseCase)
      : super(ChangePasswordInitial()) {
    on<ChangePasswordSubmitted>((event, emit) async {
      emit(ChangePasswordLoading());

      final result =
      await changePasswordUseCase(event.newPassword, event.confirmPassword);

      result.fold(
        (failure) => emit(ChangePasswordFailure(failure.message)),
        (success) => emit(ChangePasswordSuccess()),
      );
    });
  }
}
