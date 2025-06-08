import 'package:flutter/material.dart';
import 'package:manam_leave_management/presentation/navigation/app_routes.dart';
import 'package:manam_leave_management/presentation/widgets/otp_input.dart';

import '../../core/theme/font_family.dart';
import '../../core/utils/app_images.dart';
import '../../core/utils/app_strings.dart';
import '../widgets/gradient_button.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(children: [
            Positioned(
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.logo3, // Replace with your actual logo asset path
                  height: 100,
                ),

                const SizedBox(height: 20),

                // Login Text
                Text(
                  AppStrings.otp.toUpperCase(),
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: FontFamily.poppins,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 20),

                OTPInput(),
                const SizedBox(height: 20),

                GradientButton(
                  width: 200,
                  text: AppStrings.submit.toUpperCase(),
                  onPressed: () {
                    AppRoutes.navigateTo(context, AppRoutes.changePassword);
                  },
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
