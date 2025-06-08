import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manam_leave_management/core/utils/app_images.dart';
import 'package:manam_leave_management/presentation/bloc/session/session_bloc.dart';

import '../../core/theme/font_family.dart';
import '../../core/utils/app_strings.dart';
import '../../core/utils/app_validators.dart';
import '../../core/utils/global_loader.dart';
import '../../core/utils/session_manager.dart';
import '../../core/utils/toast_helper.dart';
import '../../di/injection_container.dart';
import '../bloc/login/login_bloc.dart';
import '../navigation/app_routes.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/gradient_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return BlocProvider(
      create: (_) => LoginBloc(sl()),
      child: PopScope(
        canPop: true,
        onPopInvokedWithResult: (bool didPop, String? result) {
          exit(0); // Close the app
        },
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo
                    Image.asset(
                      AppImages.appLogo,
                      height: 100,
                      width: 100,
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      AppStrings.login,
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: FontFamily.poppins,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 20),

                    CustomTextField(
                      obscureText: false,
                      hintText: AppStrings.emailOrMobile,
                      isRequired: true,
                      controller: emailController,
                      validator: AppValidators.validateEmail,
                    ),

                    const SizedBox(height: 20),

                    CustomTextField(
                      obscureText: true,
                      hintText: AppStrings.password,
                      isRequired: true,
                      controller: passwordController,
                      validator: AppValidators.validatePassword,
                    ),

                    const SizedBox(height: 20),

                    BlocConsumer<LoginBloc, LoginState>(
                      listener: (context, state) {
                        if (state is LoginLoading) {
                          GlobalLoader.show();
                        } else {
                          GlobalLoader.hide();
                        }

                        if (state is LoginSuccess) {
                          SessionManager().setLoggedIn(true);
                          AppRoutes.navigateTo(context, AppRoutes.dashboard);
                        }

                        if (state is LoginFailure) {
                          ToastHelper.showToast(state.error);
                        }
                      },
                      builder: (context, state) {
                        return GradientButton(
                          text: AppStrings.login.toUpperCase(),
                          onPressed: state is LoginLoading
                              ? () {}
                              : () {
                                  if (formKey.currentState!.validate()) {
                                    context.read<LoginBloc>().add(
                                          LoginSubmitted(
                                            email: emailController.text.trim(),
                                            password:
                                                passwordController.text.trim(),
                                          ),
                                        );
                                  }
                                },
                        );
                      },
                    ),

                    const SizedBox(height: 20),

                    TextButton(
                      onPressed: () {
                        AppRoutes.navigateTo(context, AppRoutes.forgotPassword);
                      },
                      child: const Text(
                        "${AppStrings.forgotPassword}?",
                        style: TextStyle(
                          color: Colors.blue,
                          fontFamily: FontFamily.poppins,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
