import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_circular_progress_indicator/gradient_circular_progress_indicator.dart';
import 'package:manam_leave_management/core/utils/app_validators.dart';
import 'package:manam_leave_management/core/utils/session_manager.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/font_family.dart';
import '../../core/utils/app_strings.dart';
import '../../core/utils/global_loader.dart';
import '../../data/models/response/balance_model.dart';
import '../../di/injection_container.dart';
import '../../domain/entities/login_entity.dart';
import '../bloc/profile/profile_bloc.dart';
import '../navigation/app_routes.dart';
import '../widgets/confirm_action_dialog.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProfileBloc>()..add(LoadUserProfile()),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  GlobalLoader.show();
                });
              } else {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  GlobalLoader.hide();
                });
              }

              if (state is ProfileLoaded) {
                final user = state.user;

                final casual = user.balances.firstWhere(
                    (b) => b.balanceType == "CASUAL_LEAVE",
                    orElse: () => BalanceModel(
                        balanceType: "CASUAL_LEAVE",
                        allocated: 0,
                        used: 0,
                        pending: 0));
                final sick = user.balances.firstWhere(
                    (b) => b.balanceType == "SICK_LEAVE",
                    orElse: () => BalanceModel(
                        balanceType: "SICK_LEAVE",
                        allocated: 0,
                        used: 0,
                        pending: 0));
                final wfh = user.balances.firstWhere(
                    (b) => b.balanceType == "WFH",
                    orElse: () => BalanceModel(
                        balanceType: "WFH", allocated: 0, used: 0, pending: 0));

                return Stack(
                  children: [
                    Column(
                      children: [
                        _buildGreetingHeader(context, user),
                        const SizedBox(height: 80),
                      ],
                    ),
                    Positioned(
                      top: 90,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: SizedBox(
                          width: 380,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _buildProfileCard(casual, sick, wfh),
                              const SizedBox(height: 20),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxHeight:
                                      MediaQuery.of(context).size.height - 300,
                                ),
                                child: SingleChildScrollView(
                                  child: _buildForm(user),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
              return const Center(child: Text("Something went wrong"));
            },
          ),
        ),
      ),
    );
  }

  Widget _buildGreetingHeader(BuildContext context, LoginEntity user) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.gradient1, AppColors.gradient2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
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
                const SizedBox(width: 10),
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
                      child: Icon(Icons.notifications_rounded,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
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
                  showConfirmDialog(
                    context: context,
                    title: "Confirm Logout",
                    description: "Are you sure you want to logout?",
                    confirmText: "Logout",
                    cancelText: "Cancel",
                    onConfirm: () {
                      SessionManager().clearAll();
                      AppRoutes.navigateTo(context, AppRoutes.login);
                    },
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(5.0), // Increase tap target size
                  child: Icon(
                    Icons.logout_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(
      BalanceModel casual, BalanceModel sick, BalanceModel wfh) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(AppStrings.leaveCard,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                Row(
                  children: [
                    _buildLegendDot([AppColors.gradient1, AppColors.gradient2]),
                    const SizedBox(width: 4),
                    const Text(AppStrings.used,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.deepPurple,
                            fontFamily: FontFamily.poppins,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(width: 12),
                    _buildLegendDot(
                        [Colors.grey.shade300, Colors.grey.shade300]),
                    const SizedBox(width: 4),
                    Text(AppStrings.balance,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                            fontFamily: FontFamily.poppins,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildLeaveCircle(
                  title: "Casual",
                  percent: casual.allocated == 0
                      ? 0
                      : casual.used / casual.allocated,
                  availed: "${casual.used}d",
                  balance: "${casual.pending}d",
                ),
                _buildLeaveCircle(
                  title: "Sick",
                  percent: sick.allocated == 0 ? 0 : sick.used / sick.allocated,
                  availed: "${sick.used}d",
                  balance: "${sick.pending}d",
                ),
                _buildLeaveCircle(
                  title: "WFH",
                  percent: wfh.allocated == 0 ? 0 : wfh.used / wfh.allocated,
                  availed: "${wfh.used}d",
                  balance: "${wfh.pending}d",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendDot(List<Color> colors) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
          shape: BoxShape.circle, gradient: LinearGradient(colors: colors)),
    );
  }

  Widget _buildLeaveCircle({
    required String title,
    required double percent,
    required String availed,
    required String balance,
  }) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Animated progress indicator
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0.0, end: percent),
              duration: const Duration(seconds: 2), // Adjust the duration
              builder: (context, value, child) {
                return GradientCircularProgressIndicator(
                  progress: value,
                  gradient: const LinearGradient(
                    colors: [AppColors.gradient1, AppColors.gradient2],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  backgroundColor: Colors.grey.shade300,
                  stroke: 8,
                  size: 60,
                );
              },
            ),
            Text(
              "${(percent * 100).toInt()}%",
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontFamily: FontFamily.poppins,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            fontFamily: FontFamily.poppins,
          ),
        ),
        const SizedBox(height: 4),
        RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black87,
            ),
            children: [
              TextSpan(
                text: "${availed} | ",
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontFamily: FontFamily.poppins,
                    fontWeight: FontWeight.w600),
              ),
              TextSpan(
                text: balance,
                style: TextStyle(
                    color: Colors.grey.shade600,
                    fontFamily: FontFamily.poppins,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildForm(LoginEntity user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          AppStrings.welcomeBack,
          style: TextStyle(
            fontSize: 26,
            fontFamily: FontFamily.poppins,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 20),
        _outlinedTextField(label: "Full Name", hint: user.name ?? ''),
        const SizedBox(height: 20),
        _outlinedTextField(label: "Email", hint: user.email ?? ''),
        const SizedBox(height: 20),
        _outlinedTextField(
            label: "Mobile Number", hint: user.mobileNumber ?? ''),
        const SizedBox(height: 20),
        _outlinedTextField(label: "Designation", hint: user.designation ?? ''),
        const SizedBox(height: 20),
        _outlinedTextField(label: "DOB", hint: user.dob ?? ''),
      ],
    );
  }

  Widget _outlinedTextField({required String label, required String hint}) {
    return TextFormField(
      readOnly: true,
      initialValue: hint,
      decoration: InputDecoration(
        labelText: '$label *',
        hintText: hint,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              const BorderSide(color: AppColors.borderColor1, width: 1.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.deepPurple, width: 1.8),
        ),
      ),
    );
  }
}
