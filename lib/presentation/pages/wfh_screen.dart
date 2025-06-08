import 'package:flutter/material.dart';
import 'package:manam_leave_management/core/theme/font_family.dart';
import 'package:manam_leave_management/core/utils/app_images.dart';
import 'package:manam_leave_management/core/utils/app_strings.dart';
import 'package:manam_leave_management/core/utils/session_manager.dart';
import 'package:manam_leave_management/presentation/widgets/leave_item.dart';
import 'package:manam_leave_management/core/utils/date_validator.dart';

import '../../core/utils/app_validators.dart';
import '../widgets/date_picker_widget.dart';

class WFHScreen extends StatelessWidget {
  const WFHScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUserApplications = SessionManager().applications;

    // Check if there is no WFH data or it's empty
    if (currentUserApplications == null ||
        currentUserApplications.wfh.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.wfh, // Replace with your asset name
              height: 200,
            ),
            const SizedBox(height: 30),
            const Text(
              AppStrings.noWFH, // Replace with your string
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

    // Extract the WFH map from the session
    final wfhDataMap = currentUserApplications.wfh;
    final months = wfhDataMap.keys.toList()
      ..sort((a, b) => b.compareTo(a)); // Sort months in descending order

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: months.map((month) {
          final wfhItems = wfhDataMap[month]!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Month header with optional calendar picker
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
                    splashColor: Colors.deepPurple.shade100,
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

              // WFH items
              Column(
                children: wfhItems.map((wfh) {
                  return LeaveItem(
                    id: wfh.id,
                    duration:
                        wfh.requestedWorkingDays,
                    date:
                        "${DateValidator.formatDate(wfh.fromDate)} - ${DateValidator.formatDate(wfh.toDate)}",
                    reason: wfh.reason,
                    status: wfh.status,
                    leaveType: AppValidators.formatLeaveType(wfh.requestType),
                    fromDate: DateValidator.parseDate(wfh.fromDate),
                    toDate: DateValidator.parseDate(wfh.toDate),
                    managers: [wfh.decidedBy.name],
                    totalDays: wfh.requestedWorkingDays ?? 1,
                    hideLeaveType: true,
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
            ],
          );
        }).toList(),
      ),
    );
  }
}
