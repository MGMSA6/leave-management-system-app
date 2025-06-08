import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/app_images.dart';
import '../../core/utils/logo_animation.dart';
import '../cubit/splash/splash_cubit.dart';
import '../cubit/splash/splash_state.dart';
import '../navigation/app_routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashCompleted) {
            AppRoutes.navigateTo(context, AppRoutes.login);
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                /// Center Logo
                Center(
                  child: BlocBuilder<SplashCubit, SplashState>(
                    builder: (context, state) {
                      return LogoAnimation(
                          imagePath: AppImages.appLogo,
                          onAnimationComplete: () {
                            context.read<SplashCubit>().checkAuthStatus();
                          });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
