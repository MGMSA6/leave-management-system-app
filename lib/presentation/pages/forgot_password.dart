import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manam_leave_management/core/utils/app_images.dart';
import 'package:manam_leave_management/core/utils/global_loader.dart';
import 'package:manam_leave_management/core/utils/session_manager.dart';
import '../../core/utils/app_strings.dart';
import '../../core/utils/app_validators.dart';
import '../../core/utils/toast_helper.dart';
import '../../di/injection_container.dart';
import '../bloc/verify/verify_email_bloc.dart';
import '../navigation/app_routes.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/gradient_button.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController emailController = TextEditingController();

    return Scaffold(
      body: BlocProvider(
        create: (context) => VerifyEmailBloc(sl()),
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

                    // Email/Mobile Input Field
                    CustomTextField(
                      obscureText: false,
                      hintText: AppStrings.enterEmail,
                      isRequired: true,
                      controller: emailController,
                      validator: (value) => AppValidators.validateEmail(value),
                    ),

                    const SizedBox(height: 20),

                    BlocConsumer<VerifyEmailBloc, VerifyEmailState>(
                      listener: (context, state) {
                        print(
                            'State changed: ${state.runtimeType}'); // Debug print

                        if (state is VerifyEmailLoading) {
                          GlobalLoader.show();
                        } else {
                          GlobalLoader.hide();
                        }

                        if (state is VerifyEmailSuccess) {
                          SessionManager()
                              .setAuthToken(state.verifyEmailEntity.token);
                          AppRoutes.navigateTo(
                              context, AppRoutes.changePassword);
                        } else if (state is VerifyEmailFailure) {
                          print('Error: ${state.error}'); // Debug print
                          ToastHelper.showToast(state.error);
                        }
                      },
                      builder: (context, state) {
                        return GradientButton(
                          text: AppStrings.getOtp,
                          onPressed: () {
                            print('Button pressed'); // Debug print
                            if (formKey.currentState!.validate()) {
                              print(
                                  'Form is valid, submitting email'); // Debug print
                              context.read<VerifyEmailBloc>().add(
                                    VerifyEmailSubmitted(
                                      email: emailController.text.trim(),
                                    ),
                                  );
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

// Alternative StatefulWidget approach if the above doesn't work
class ForgotPasswordAlternative extends StatefulWidget {
  const ForgotPasswordAlternative({super.key});

  @override
  State<ForgotPasswordAlternative> createState() =>
      _ForgotPasswordAlternativeState();
}

class _ForgotPasswordAlternativeState extends State<ForgotPasswordAlternative> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  late VerifyEmailBloc verifyEmailBloc;

  @override
  void initState() {
    super.initState();
    verifyEmailBloc = VerifyEmailBloc(sl());
  }

  @override
  void dispose() {
    emailController.dispose();
    verifyEmailBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider.value(
        value: verifyEmailBloc,
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

                    // Email/Mobile Input Field
                    CustomTextField(
                      obscureText: false,
                      hintText: AppStrings.enterEmail,
                      isRequired: true,
                      controller: emailController,
                      validator: (value) => AppValidators.validateEmail(value),
                    ),

                    const SizedBox(height: 20),

                    BlocConsumer<VerifyEmailBloc, VerifyEmailState>(
                      listener: (context, state) {
                        if (state is VerifyEmailLoading) {
                          GlobalLoader.show();
                        } else {
                          GlobalLoader.hide();
                        }

                        if (state is VerifyEmailSuccess) {
                          Navigator.pushNamed(context, AppRoutes.otp);
                        } else if (state is VerifyEmailFailure) {
                          ToastHelper.showToast(state.error);
                        }
                      },
                      builder: (context, state) {
                        return GradientButton(
                          text: AppStrings.getOtp,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              verifyEmailBloc.add(
                                VerifyEmailSubmitted(
                                  email: emailController.text.trim(),
                                ),
                              );
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
