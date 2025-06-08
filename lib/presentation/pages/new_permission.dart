import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:manam_leave_management/core/theme/font_family.dart';
import 'package:manam_leave_management/data/models/response/permission_model.dart';
import 'package:manam_leave_management/presentation/navigation/app_routes.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/app_constants.dart';
import '../../core/utils/app_strings.dart';
import '../../core/utils/date_validator.dart';
import '../../core/utils/global_loader.dart';
import '../../core/utils/session_manager.dart';
import '../../core/utils/toast_helper.dart';
import '../../data/models/request/create_permission_model.dart';
import '../../di/injection_container.dart';
import '../bloc/permission/new_permission_bloc.dart';
import '../bloc/permission/new_permission_event.dart';
import '../bloc/permission/new_permission_state.dart';
import '../widgets/date_picker_widget.dart';
import '../widgets/gradient_button.dart';
import '../widgets/leave_reason_dialog.dart';
import '../widgets/management_selection_dialog.dart';
import '../widgets/status_dialog.dart';
import '../widgets/time_picker_widget.dart';

class NewPermission extends StatelessWidget {
  final PermissionModel? permissionModel;

  const NewPermission({super.key, this.permissionModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewPermissionBloc(sl()),
      child: const NewPermissionView(),
    );
  }
}

class NewPermissionView extends StatelessWidget {
  const NewPermissionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewPermissionBloc, NewPermissionState>(
      listener: (context, state) {
        if (state.status == NewPermissionStatus.submitting) {
          GlobalLoader.show();
        } else {
          GlobalLoader.hide();
        }
        // on success
        if (state.status == NewPermissionStatus.success) {
          CustomStatusDialog.show(
            context: context,
            title: AppStrings.leaveApplied,
            image: const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 64,
            ),
            onButtonPressed: () {
              Navigator.of(context).pop();
              AppRoutes.navigateTo(context, AppRoutes.dashboard);
            },
          );
        }
        // on failure
        if (state.status == NewPermissionStatus.failure) {
          print("NewLeaveStatusError: ${state.errorMessage}");
          ToastHelper.showErrorToast(
              state.errorMessage ?? 'Failed to apply request');
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: BlocBuilder<NewPermissionBloc, NewPermissionState>(
                builder: (context, state) {
                  return GradientButton(
                    text: "Applying for ${state.totalTime} Hours Permission",
                    textStyle: TextStyle(
                      letterSpacing: 1.5, // Override letter spacing here
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16, // Adjust font size if needed
                    ),
                    onPressed: () {
                      // Final submit logic (call a method or navigate)

                      final managerId = SessionManager()
                          .user!
                          .superiors
                          .firstWhere((s) =>
                              s.name.split(' ').first == state.managers.first)
                          .id;

                      final params = CreatePermissionModel(
                          startTime: DateFormat(AppConstants.timeFormat)
                              .format(state.fromTime),
                          endTime: DateFormat(AppConstants.timeFormat)
                              .format(state.toTime),
                          reason: state.reason,
                          managerId: managerId);

                      context
                          .read<NewPermissionBloc>()
                          .add(SubmitPermission(createPermissionModel: params));
                    },
                  );
                },
              ),
            ),
          ),
          body: SafeArea(
            child: BlocBuilder<NewPermissionBloc, NewPermissionState>(
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildHeader(context),
                        const SizedBox(height: 20),
                        _buildForm(context, state),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
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
        Text(
          AppStrings.newPermission,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildForm(BuildContext context, NewPermissionState state) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          _buildTile(
            icon: Icons.edit_rounded,
            title: AppStrings.reason,
            value: state.reason,
            onTap: () => showLeaveReasonDialog(
              context,
              (reason) => context
                  .read<NewPermissionBloc>()
                  .add(EnterPermissionReason(reason)),
              initialReason: state.reason,
            ),
          ),
          const SizedBox(height: 10),
          const Divider(color: AppColors.divider),
          const SizedBox(height: 10),
          _buildTile(
            icon: Icons.calendar_month_rounded,
            title: AppStrings.fromDate,
            value: DateValidator.formatDate1(state.fromDate),
            onTap: () => showDatePickerDialog(
              context,
              (date) =>
                  context.read<NewPermissionBloc>().add(SelectFromDate(date)),
              title: 'Select From Date',
              disablePastDates: true,
              initialDate: state.fromDate,
            ),
          ),
          const SizedBox(height: 10),
          const Divider(color: AppColors.divider),
          const SizedBox(height: 10),
          _buildTile(
            icon: Icons.access_time_filled_rounded,
            title: AppStrings.fromTime,
            value: DateValidator.formatTime1(state.fromTime),
            onTap: () {
              showTimePickerDialog(
                context,
                (selectedDateTime) {
                  context
                      .read<NewPermissionBloc>()
                      .add(SelectFromTime(selectedDateTime));
                  print("Selected time: $selectedDateTime");
                  // Use the selected time however you need here.
                },
                title: "Select Time",
              );
            },
          ),
          const SizedBox(height: 10),
          const Divider(color: AppColors.divider),
          const SizedBox(height: 10),
          _buildTile(
            icon: Icons.calendar_month_rounded,
            title: AppStrings.toDate,
            value: DateValidator.formatDate1(state.toDate),
            onTap: () => showDatePickerDialog(
              context,
              (date) =>
                  context.read<NewPermissionBloc>().add(SelectToDate(date)),
              title: 'Select To Date',
              disablePastDates: true,
              initialDate: state.toDate,
            ),
          ),
          const SizedBox(height: 10),
          const Divider(color: AppColors.divider),
          const SizedBox(height: 10),
          _buildTile(
            icon: Icons.access_time_filled_rounded,
            title: AppStrings.toTime,
            value: DateValidator.formatTime1(state.toTime),
            onTap: () {
              showTimePickerDialog(
                context,
                (selectedDateTime) {
                  context
                      .read<NewPermissionBloc>()
                      .add(SelectToTime(selectedDateTime));
                  print("Selected time: ${selectedDateTime}");
                  // Use the selected time however you need here.
                },
                title: "Select Time",
              );
            },
          ),
          const SizedBox(height: 10),
          const Divider(color: AppColors.divider),
          const SizedBox(height: 10),
          _buildTile(
            icon: Icons.group_rounded,
            title: AppStrings.management,
            value: state.managers.join(', '),
            onTap: () => showManagementSelectionDialog(
              context,
              state.managers, // use whatever is currently selected
              (managers) {
                context
                    .read<NewPermissionBloc>()
                    .add(SelectManagement(managers));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      splashColor: Colors.transparent,
      child: Row(
        children: [
          Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            child: Ink(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.gradient1, AppColors.gradient2],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: onTap,
                splashColor: Colors.white.withAlpha(60),
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: Icon(icon, color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w400,
                    fontFamily: FontFamily.poppins,
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    value,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontFamily: FontFamily.poppins,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
