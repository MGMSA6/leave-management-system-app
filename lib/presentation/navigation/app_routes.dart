import 'package:flutter/material.dart';
import 'package:manam_leave_management/presentation/pages/dashboard.dart';
import 'package:manam_leave_management/presentation/pages/login_screen.dart';
import 'package:manam_leave_management/presentation/pages/new_leave.dart';
import 'package:manam_leave_management/presentation/pages/new_permission.dart';
import 'package:manam_leave_management/presentation/pages/notification_screen.dart';
import 'package:manam_leave_management/presentation/pages/otp_screen.dart';
import 'package:manam_leave_management/presentation/pages/permissions_screen.dart';

import '../pages/forgot_password.dart';
import '../pages/new_wfh.dart';
import '../pages/change_password.dart';
import '../pages/splash_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String otp = '/otp';
  static const String forgotPassword = '/forgotPassword';
  static const String dashboard = '/dashboard';
  static const String newLeave = '/newLeave';
  static const String notification = '/notification';
  static const String newPermission = '/newPermission';
  static const String workFromHome = '/workFromHome';
  static const String changePassword = '/changePassword';

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case AppRoutes.otp:
        return MaterialPageRoute(builder: (context) => const OtpScreen());
      case AppRoutes.forgotPassword:
        return MaterialPageRoute(builder: (context) => const ForgotPassword());
      case AppRoutes.dashboard:
        return MaterialPageRoute(builder: (context) => const Dashboard());
      case AppRoutes.newLeave:
        return MaterialPageRoute(builder: (context) => const NewLeave());
      case AppRoutes.notification:
        return MaterialPageRoute(
            builder: (context) => const NotificationScreen());
      case AppRoutes.newPermission:
        return MaterialPageRoute(builder: (context) => const NewPermission());
      case AppRoutes.workFromHome:
        return MaterialPageRoute(builder: (context) => const NewWFH());
      case AppRoutes.changePassword:
        return MaterialPageRoute(builder: (context) => const ChangePassword());
      default:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
    }
  }

  /// Navigate to a screen using named routes
  static void navigateTo(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  /// Navigate and remove all previous screens (useful for splash screens)
  static void navigateAndRemoveUntil(BuildContext context, String routeName) {
    Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);
  }

  static void pushScreenWithData<T>(
    BuildContext context, {
    required Widget Function(T data) screenBuilder,
    required T data,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screenBuilder(data)),
    );
  }
}
