import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manam_leave_management/core/utils/app_images.dart';
import 'package:manam_leave_management/presentation/bloc/change_password/change_password_bloc.dart';
import '../../core/theme/font_family.dart';
import '../../core/utils/app_strings.dart';
import '../../core/utils/app_validators.dart';
import '../../core/utils/global_loader.dart';
import '../../core/utils/toast_helper.dart';
import '../../di/injection_container.dart';
import '../navigation/app_routes.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/gradient_button.dart';
import '../widgets/status_dialog.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

    return Scaffold(
      body: BlocProvider(
        create: (context) => ChangePasswordBloc(sl()),
        child: Stack(
          children: [
            // Back Button at Top-Left
            Positioned(
              top: 60,
              left: 20,
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () => Navigator.pop(context),
                  splashColor: Colors.grey.withAlpha(30),
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    child: const Icon(Icons.arrow_back_ios_rounded),
                  ),
                ),
              ),
            ),

            // Main Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo
                    Image.asset(
                      AppImages.logo3,
                      height: 100,
                    ),

                    const SizedBox(height: 40),

                    // New Password Input Field
                    CustomTextField(
                      hintText: AppStrings.newPassword,
                      isRequired: true,
                      controller: newPasswordController,
                      validator: (value) =>
                          AppValidators.validatePassword(value),
                      obscureText: true,
                    ),

                    const SizedBox(height: 20),

                    // Confirm Password Input Field
                    CustomTextField(
                      obscureText: true,
                      hintText: AppStrings.confirmPassword,
                      isRequired: true,
                      controller: confirmPasswordController,
                      validator: (value) {
                        // Validate password match
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != newPasswordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
                      listener: (context, state) {
                        print(
                            'State changed: ${state.runtimeType}'); // Debug print

                        if (state is ChangePasswordLoading) {
                          print('Showing loader'); // Debug print
                          GlobalLoader.show();
                        } else {
                          print('Hiding loader'); // Debug print
                          GlobalLoader.hide();
                        }

                        if (state is ChangePasswordSuccess) {
                          print('Navigation to login'); // Debug print
                          CustomStatusDialog.show(
                            context: context,
                            title: AppStrings.passwordChanged,
                            image: const Icon(
                              Icons.check_circle_outline,
                              color: Colors.green,
                              size: 64,
                            ),
                            onButtonPressed: () {
                              AppRoutes.navigateTo(context, AppRoutes.login);
                            },
                          );
                        } else if (state is ChangePasswordFailure) {
                          print('Error: ${state.error}'); // Debug print
                          ToastHelper.showToast(state.error);
                        }
                      },
                      builder: (context, state) {
                        return GradientButton(
                          text: AppStrings.submit,
                          onPressed: () {
                            print('Submit button pressed'); // Debug print
                            if (formKey.currentState!.validate()) {
                              if (newPasswordController.text.trim() ==
                                  confirmPasswordController.text.trim()) {
                                context.read<ChangePasswordBloc>().add(
                                      ChangePasswordSubmitted(
                                        newPassword:
                                            newPasswordController.text.trim(),
                                        confirmPassword:
                                            confirmPasswordController.text
                                                .trim(),
                                      ),
                                    );
                              } else {
                                ToastHelper.showErrorToast(
                                    "New Password and Confirm Password does not match!");
                              }
                            } else {
                              print('Form validation failed'); // Debug print
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
