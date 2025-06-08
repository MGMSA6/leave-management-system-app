import 'package:flutter/material.dart';
import 'package:manam_leave_management/core/utils/app_images.dart';
import 'package:manam_leave_management/core/utils/app_strings.dart';
import 'package:manam_leave_management/core/utils/date_validator.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/font_family.dart';
import '../../core/utils/session_manager.dart';
import '../widgets/date_picker_widget.dart';
import '../widgets/permission_item.dart';

class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUserApplications = SessionManager().applications;

    // Check if there is no permission data or it's empty
    if (currentUserApplications == null ||
        currentUserApplications.permission.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.noData, // Add your 'no permissions' image asset here
              height: 200,
            ),
            const SizedBox(height: 30),
            const Text(
              AppStrings.noPermissions,
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

    // Extract the permissions map from the session
    final permissionDataMap = currentUserApplications.permission;
    final months = permissionDataMap.keys.toList()
      ..sort((a, b) => b.compareTo(a)); // Sort months in descending order

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: List.generate(months.length, (index) {
          final month = months[index];
          final permissions = permissionDataMap[month]!;

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

              // Permission Items
              Column(
                children: permissions.map((permission) {
                  return PermissionItem(
                    duration: DateValidator.convertMinutesToHours(
                        permission.durationMinutes),
                    date: DateValidator.formatDate(permission.createdOn),
                    fromTime: DateValidator.formatTime(permission.startTime),
                    toTime: DateValidator.formatTime(permission.endTime),
                    status: permission.status,
                    reason: permission.reason,
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
