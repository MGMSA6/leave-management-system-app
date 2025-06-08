import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manam_leave_management/core/utils/app_validators.dart';
import 'package:manam_leave_management/core/utils/date_validator.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/font_family.dart';
import '../../core/utils/app_images.dart';
import '../../core/utils/app_strings.dart';
import '../../core/utils/global_loader.dart';
import '../../core/utils/session_manager.dart';
import '../../core/utils/toast_helper.dart';
import '../../di/injection_container.dart';
import '../bloc/CurrentUserApplication/current_user_application_bloc.dart';
import '../bloc/request/new_request_bloc.dart';
import '../bloc/request/new_request_state.dart';
import '../widgets/date_picker_widget.dart';
import '../widgets/leave_item.dart';

class LeavesScreen extends StatefulWidget {
  const LeavesScreen({super.key});

  @override
  State<LeavesScreen> createState() => _LeavesScreenState();
}

class _LeavesScreenState extends State<LeavesScreen> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<CurrentUserApplicationBloc>();
    if (bloc.state is! CurrentUserApplicationLoaded) {
      bloc.stream.listen((state) {
        if (state is CurrentUserApplicationLoaded && mounted) {
          setState(() {}); // Trigger UI rebuild
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewRequestBloc(sl(), sl(), sl()),
      child: BlocListener<NewRequestBloc, NewRequestState>(
        listener: (context, state) {
          if (state.status == NewRequestStatus.submitting) {
            GlobalLoader.show();
          } else {
            GlobalLoader.hide();
          }

          if (state.status == NewRequestStatus.delete) {
            ToastHelper.showErrorToast("Leave deleted successfully");
          }

          if (state.status == NewRequestStatus.failure) {
            ToastHelper.showErrorToast(state.errorMessage ?? 'Something went wrong');
          }
        },
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final currentUserApplications = SessionManager().applications;

    if (currentUserApplications == null ||
        currentUserApplications.leave.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.noLeave, height: 200),
            const SizedBox(height: 30),
            const Text(
              AppStrings.noLeaves,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontFamily: FontFamily.poppins,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      );
    }

    final leaveDataMap = currentUserApplications.leave;
    final months = leaveDataMap.keys.toList()..sort((a, b) => b.compareTo(a));

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: List.generate(months.length, (index) {
          final month = months[index];
          final leaves = leaveDataMap[month]!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Month Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateValidator.formatMonthYear(month),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: FontFamily.poppins,
                    ),
                  ),
                  if (index == 0)
                    InkWell(
                      onTap: () {
                        showDatePickerDialog(
                          context,
                          (date) {
                            print("Selected month: $date");
                          },
                          title: 'Select To Date',
                          disablePastDates: false,
                        );
                      },
                      splashColor: AppColors.splashColor,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 1.5,
                            color: Colors.deepPurple,
                          ),
                        ),
                        child: Row(
                          children: const [
                            Text(
                              AppStrings.months,
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 14,
                                fontFamily: FontFamily.poppins,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Icons.calendar_month_rounded,
                              color: Colors.deepPurple,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 10),

              // Leave Items
              Column(
                children: leaves.map((leave) {
                  return LeaveItem(
                    id: leave.id,
                    duration: leave.requestedWorkingDays,
                    date:
                        "${DateValidator.formatDate(leave.fromDate)} - ${DateValidator.formatDate(leave.toDate)}",
                    reason: leave.reason,
                    status: leave.status,
                    leaveType: AppValidators.formatLeaveType(leave.requestType),
                    fromDate: DateValidator.parseDate(leave.fromDate),
                    toDate: DateValidator.parseDate(leave.toDate),
                    managers: [leave.decidedBy.name],
                    totalDays: leave.requestedWorkingDays ?? 1,
                    hideLeaveType: false,
                  );
                }).toList(),
              ),

              const SizedBox(height: 24),
            ],
          );
        }),
      ),
    );
  }
}
