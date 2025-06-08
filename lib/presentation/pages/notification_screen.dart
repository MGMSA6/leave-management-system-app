import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:manam_leave_management/core/utils/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/font_family.dart';
import '../../core/utils/app_images.dart'; // Update this import based on your path

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Light background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Material(
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
                  const SizedBox(width: 15),
                  const Text(
                    'Notifications',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 80),

              // Center Image
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Transform.rotate(
                        angle: 0.25,
                        child: Image.asset(
                          AppImages.bell, // Replace with your image path
                          height: 250,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        AppStrings.noNotification,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          fontFamily: FontFamily.poppins,
                          color: AppColors.textColor1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
