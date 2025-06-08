import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/utils/session_manager.dart';
import '../../../domain/entities/current_user_application_entity.dart';
import '../../../domain/usecases/current_user_application_usecase.dart';

part 'current_user_application_event.dart';

part 'current_user_application_state.dart';

class CurrentUserApplicationBloc
    extends Bloc<CurrentUserApplicationEvent, CurrentUserApplicationState> {
  final CurrentUserApplicationUseCase useCase;

  CurrentUserApplicationBloc(this.useCase)
      : super(CurrentUserApplicationInitial()) {
    on<FetchCurrentUserApplications>((event, emit) async {
      emit(CurrentUserApplicationLoading());

      final result = await useCase.call();

      result.fold(
        (failure) => emit(CurrentUserApplicationError(failure.message)),
        (data) {
          SessionManager().setApplications(data);
          emit(CurrentUserApplicationLoaded(data));
        },
      );
    });
  }
}
