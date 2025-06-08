import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:manam_leave_management/core/utils/session_manager.dart';

import '../../../domain/entities/login_entity.dart';
import '../../../domain/usecases/login_usecase.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc(
    this.loginUseCase,
  ) : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());

      final result = await loginUseCase(event.email, event.password);

      result.fold(
        (failure) => emit(LoginFailure(failure.message)),
        (loginEntity) {
          SessionManager().setUser(loginEntity);
          SessionManager().setAuthToken(loginEntity.authToken);
          emit(LoginSuccess(loginEntity));
        },
      );
    });
  }
}
