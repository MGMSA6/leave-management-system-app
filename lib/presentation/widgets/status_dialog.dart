import 'package:flutter/material.dart';
import 'package:manam_leave_management/core/theme/font_family.dart';

import '../navigation/app_routes.dart';

class CustomStatusDialog extends StatelessWidget {
  final String title;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final Widget? image;
  final Color backgroundColor;
  final Color buttonColor;
  final Color buttonTextColor;

  const CustomStatusDialog({
    Key? key,
    required this.title,
    this.buttonText = 'Done',
    required this.onButtonPressed,
    this.image,
    this.backgroundColor = Colors.white,
    this.buttonColor = Colors.blue,
    this.buttonTextColor = Colors.white,
  }) : super(key: key);

  /// Factory constructor with success tick mark
  factory CustomStatusDialog.success({
    required String title,
    String buttonText = 'Done',
    required VoidCallback onButtonPressed,
    Color backgroundColor = Colors.white,
    Color buttonColor = Colors.green,
  }) {
    return CustomStatusDialog(
      title: title,
      buttonText: buttonText,
      onButtonPressed: onButtonPressed,
      backgroundColor: backgroundColor,
      buttonColor: buttonColor,
      image: const Icon(
        Icons.check_circle_outline,
        color: Colors.green,
        size: 64,
      ),
    );
  }

  /// Factory constructor with error icon
  factory CustomStatusDialog.error({
    required String title,
    String buttonText = 'OK',
    required VoidCallback onButtonPressed,
    Color backgroundColor = Colors.white,
    Color buttonColor = Colors.red,
  }) {
    return CustomStatusDialog(
      title: title,
      buttonText: buttonText,
      onButtonPressed: onButtonPressed,
      backgroundColor: backgroundColor,
      buttonColor: buttonColor,
      image: const Icon(
        Icons.error_outline,
        color: Colors.red,
        size: 64,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Display image if provided
          if (image != null) ...[
            image!,
            const SizedBox(height: 20),
          ],
          // Display title text
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontFamily: FontFamily.poppins,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          // Custom button
          InkWell(
            onTap: onButtonPressed,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: 16,
                  color: buttonTextColor,
                  fontFamily: FontFamily.poppins,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Helper method to show the dialog
  /// Helper method to show the dialog
  static Future<void> show({
    required BuildContext context,
    required String title,
    String buttonText = 'Done',
    required VoidCallback onButtonPressed,
    Widget? image,
    Color backgroundColor = Colors.white,
    Color buttonColor = Colors.blue,
    Color buttonTextColor = Colors.white,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, String? result) async {
          // Close the dialog
          Navigator.of(dialogContext).pop();
          // Then navigate to the dashboard
          AppRoutes.navigateTo(dialogContext, AppRoutes.dashboard);
        },
        child: CustomStatusDialog(
          title: title,
          buttonText: buttonText,
          onButtonPressed: onButtonPressed,
          image: image,
          backgroundColor: backgroundColor,
          buttonColor: buttonColor,
          buttonTextColor: buttonTextColor,
        ),
      ),
    );
  }
}
