import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manam_leave_management/core/theme/app_colors.dart';
import 'package:manam_leave_management/core/theme/font_family.dart';
import 'package:manam_leave_management/core/utils/app_strings.dart';
import 'package:manam_leave_management/core/utils/app_validators.dart';
import 'package:manam_leave_management/core/utils/global_loader.dart';
import 'package:manam_leave_management/core/utils/toast_helper.dart';
import 'package:manam_leave_management/domain/entities/login_entity.dart';
import 'package:manam_leave_management/presentation/navigation/app_routes.dart';
import 'package:manam_leave_management/presentation/pages/permissions_screen.dart';
import 'package:manam_leave_management/presentation/pages/wfh_screen.dart';

import '../../core/utils/session_manager.dart';
import '../bloc/CurrentUserApplication/current_user_application_bloc.dart';
import '../widgets/custom_segmented_control.dart';
import 'leaves_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedTab = 0;
  PageController _pageController = PageController(initialPage: 0);
  DateTime? _lastPressedAt;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedTab);

    context
        .read<CurrentUserApplicationBloc>()
        .add(FetchCurrentUserApplications());
  }

  void _onSegmentChanged(int index) {
    setState(() {
      selectedTab = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
      );
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = SessionManager().user;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, String? result) {
        final now = DateTime.now();
        if (_lastPressedAt == null ||
            now.difference(_lastPressedAt!) > const Duration(seconds: 2)) {
          _lastPressedAt = now;
          ToastHelper.showToast(AppStrings.appExitMsg);
        } else {
          exit(0); // Close the app
        }
      },
      child:
          BlocListener<CurrentUserApplicationBloc, CurrentUserApplicationState>(
        listener: (context, state) {
          if (state is CurrentUserApplicationLoading) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              GlobalLoader.show();
            });
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              GlobalLoader.hide();
            });
          }
          if (state is CurrentUserApplicationError) {
            ToastHelper.showToast(state.message);
          } else if (state is CurrentUserApplicationLoaded) {}
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                _buildGreetingHeader(context, user!),

                const SizedBox(height: 20),

                // Custom Segmented Control
                CustomSegmentedControl(
                  currentIndex: selectedTab,
                  titles: [
                    AppStrings.leaves,
                    AppStrings.permissions,
                    AppStrings.workFromHome
                  ],
                  onValueChanged: _onSegmentChanged,
                ),

                const SizedBox(height: 10),

                // Swipe able Screens
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    children: const [
                      LeavesScreen(),
                      PermissionsScreen(),
                      WFHScreen()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGreetingHeader(BuildContext context, LoginEntity user) {
    final fullName = (user.name ?? '').trim();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.gradient1, AppColors.gradient2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hi , $fullName",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontFamily: FontFamily.poppins,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  AppStrings.feeling,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 15,
                    fontFamily: FontFamily.poppins,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ]),
          Row(
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(24),
                  // Circular ripple
                  splashColor: Colors.white.withValues(alpha: 0.3),
                  // Customize splash color
                  highlightColor: Colors.white.withValues(alpha: 0.1),
                  // Customize highlight color
                  onTap: () {
                    AppRoutes.navigateTo(context, AppRoutes.notification);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(5.0), // Increase tap target size
                    child:
                        Icon(Icons.notifications_rounded, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                    color: AppColors.gradient1.withValues(alpha: 0.5),
                    width: 3,
                  ),
                ),
                child: Center(
                  child: ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [AppColors.gradient1, AppColors.gradient2],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: Text(
                      AppValidators.getInitial(),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: FontFamily.poppins,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
