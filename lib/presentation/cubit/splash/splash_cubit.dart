import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manam_leave_management/presentation/cubit/splash/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial()) {
    checkAuthStatus(); 
  }

  void checkAuthStatus() async {
    emit(SplashLoading());

    await Future.delayed(const Duration(seconds: 2));

    emit(SplashCompleted());
  }
}
