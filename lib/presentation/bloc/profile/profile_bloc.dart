import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/login_entity.dart';
import '../../../domain/usecases/get_user_usecase.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserUseCase getUserUseCase;

  ProfileBloc(this.getUserUseCase) : super(ProfileLoading()) {
    on<LoadUserProfile>((event, emit) {
      final user = getUserUseCase();

      if (user != null) {
        emit(ProfileLoaded(user));
      } else {
        emit(ProfileLoading()); // or ProfileError if needed
      }
    });
  }
}
