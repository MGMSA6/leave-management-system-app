import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:manam_leave_management/presentation/bloc/CurrentUserApplication/current_user_application_bloc.dart';
import 'package:manam_leave_management/presentation/bloc/change_password/change_password_bloc.dart';
import 'package:manam_leave_management/presentation/bloc/holiday/holiday_bloc.dart';
import 'package:manam_leave_management/presentation/bloc/login/login_bloc.dart';
import 'package:manam_leave_management/presentation/bloc/permission/new_permission_bloc.dart';
import 'package:manam_leave_management/presentation/bloc/profile/profile_bloc.dart';
import 'package:manam_leave_management/presentation/bloc/request/new_request_bloc.dart';
import 'package:manam_leave_management/presentation/bloc/session/session_bloc.dart';
import 'package:manam_leave_management/presentation/bloc/verify/verify_email_bloc.dart';

import 'package:manam_leave_management/presentation/navigation/app_routes.dart';
import 'package:manam_leave_management/presentation/pages/login_screen.dart';
import 'package:manam_leave_management/presentation/widgets/loader_overlay.dart';

import 'core/utils/global_loader.dart';
import 'di/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set status bar and navigation bar to be transparent
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // Transparent status bar
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.transparent, // Transparent bottom nav bar
    systemNavigationBarIconBrightness: Brightness.dark,
  ));

  // Initialize GetIt service locator
  await init();

  runApp(
    ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<SessionBloc>(
            create: (_) => SessionBloc(),
          ),
          BlocProvider<LoginBloc>(
            create: (_) => LoginBloc(sl()),
          ),
          // Add global blocs here if needed
          BlocProvider<NewRequestBloc>(
            create: (_) => NewRequestBloc(sl(), sl(), sl()),
          ),
          BlocProvider<NewPermissionBloc>(
            create: (_) => NewPermissionBloc(sl()),
          ),
          BlocProvider<ProfileBloc>(
            create: (_) => ProfileBloc(sl()),
          ),
          BlocProvider<CurrentUserApplicationBloc>(
            create: (_) => CurrentUserApplicationBloc(sl()),
          ),
          BlocProvider<HolidayBloc>(
            create: (_) => HolidayBloc(sl()),
          ),
          BlocProvider<VerifyEmailBloc>(
            create: (_) => VerifyEmailBloc(sl()),
          ),
          BlocProvider<ChangePasswordBloc>(
            create: (_) => ChangePasswordBloc(sl()),
          ),
        ],
        child: MaterialApp(
          navigatorKey: GlobalLoader.navigatorKey,
          title: 'Manam Leave Management',
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.login,
          onGenerateRoute: AppRoutes.generateRoute,
          home: Stack(children: [
            LoginScreen(),
            const LoaderOverlay(),
          ]),
        ));
  }
}
