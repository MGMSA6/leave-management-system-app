import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../core/theme/font_family.dart';
import '../../core/utils/app_strings.dart';
import '../../core/utils/global_loader.dart';
import '../../core/utils/session_manager.dart';
import '../../data/models/request/create_request_model.dart';
import '../../data/models/response/leave_model.dart';
import '../../di/injection_container.dart';
import '../bloc/request/new_request_bloc.dart';
import '../bloc/request/new_request_event.dart';
import '../bloc/request/new_request_state.dart';
import '../bloc/session/session_bloc.dart';
import '../navigation/app_routes.dart';
import '../widgets/date_picker_widget.dart';
import '../widgets/gradient_button.dart';
import '../widgets/leave_reason_dialog.dart';
import '../widgets/management_selection_dialog.dart';
import '../widgets/status_dialog.dart';
import '/core/theme/app_colors.dart';
import '/core/utils/app_constants.dart';
import '/core/utils/date_validator.dart';
import '/core/utils/toast_helper.dart';

class NewWFH extends StatelessWidget {
  /// If `existingLeave` is non-null, we’re in “edit” mode.
  final LeaveModel? existingLeave;

  const NewWFH({super.key, this.existingLeave});

  @override
  Widget build(BuildContext context) {
    const defaultType = AppConstants.WFH;
    return MultiBlocProvider(
      providers: [
        BlocProvider<NewRequestBloc>(
          create: (_) {
            final bloc = NewRequestBloc(sl(), sl(), sl());
            if (existingLeave != null) {
              bloc.add(LoadRequestForEdit(existingLeave!));
            }
            return bloc;
          },
        ),
        BlocProvider<SessionBloc>(
          create: (_) {
            final bloc = SessionBloc();
            // If editing, use the passed-in leaveType; otherwise default to "WFH"
            bloc.add(GetLeaveBalanceEvent(
              leaveType: existingLeave?.leaveType ?? defaultType,
            ));
            return bloc;
          },
        ),
      ],
      child: NewWFHView(existingLeave: existingLeave),
    );
  }
}

class NewWFHView extends StatelessWidget {
  final LeaveModel? existingLeave;

  const NewWFHView({super.key, this.existingLeave});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        // Whenever requestType changes, refresh the WFH-balance via SessionBloc
        BlocListener<NewRequestBloc, NewRequestState>(
          listener: (context, state) {
            context
                .read<SessionBloc>()
                .add(GetLeaveBalanceEvent(leaveType: state.requestType));
          },
          listenWhen: (old, cur) => old.requestType != cur.requestType,
        ),
      ],
      child: BlocConsumer<NewRequestBloc, NewRequestState>(
        listener: (context, state) {
          if (state.status == NewRequestStatus.submitting) {
            GlobalLoader.show();
          } else {
            GlobalLoader.hide();
          }

          if (state.status == NewRequestStatus.success) {
            CustomStatusDialog.show(
              context: context,
              title: existingLeave == null
                  ? AppStrings.wfhApplied
                  : AppStrings.wfhUpdated,
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

          if (state.status == NewRequestStatus.failure) {
            print("NewWFHStatusError: ${state.errorMessage}");
            ToastHelper.showToast(
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
                child: BlocBuilder<NewRequestBloc, NewRequestState>(
                  builder: (context, state) {
                    return GradientButton(
                      text: state.status == NewRequestStatus.submitting
                          ? 'Submitting…'
                          : "Applying for ${state.duration} days WFH",
                      textStyle: const TextStyle(
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      onPressed: () {
                        // Ensure at least one manager is selected
                        final managerId = SessionManager()
                            .user!
                            .superiors
                            .firstWhere((s) => s.name == state.managers.first)
                            .id;

                        final params = CreateRequestModel(
                          requestType: AppConstants.WFH,
                          fromDate: DateFormat(AppConstants.dateFormat1)
                              .format(state.fromDate),
                          toDate: DateFormat(AppConstants.dateFormat1)
                              .format(state.toDate),
                          reason: state.reason,
                          decidedBy: managerId,
                        );

                        // If `existingLeave` exists and is in edit mode, dispatch UpdateRequest
                        if (existingLeave != null && existingLeave!.isEdit) {
                          context.read<NewRequestBloc>().add(
                                UpdateRequest(
                                  id: existingLeave!.id.toString(),
                                  createRequestModel: params,
                                ),
                              );
                        } else {
                          context.read<NewRequestBloc>().add(
                                SubmitRequest(createRequestModel: params),
                              );
                        }
                      },
                    );
                  },
                ),
              ),
            ),
            body: SafeArea(
              child: BlocBuilder<NewRequestBloc, NewRequestState>(
                builder: (context, state) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildHeader(context, state),
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
      ),
    );
  }

  Widget _buildHeader(BuildContext context, NewRequestState state) {
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
          existingLeave == null ? AppStrings.newWFH : AppStrings.updateWFH,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            fontFamily: FontFamily.poppins,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildForm(BuildContext context, NewRequestState state) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          _buildTile(
            icon: Icons.edit_rounded,
            title: AppStrings.reason,
            value: state.reason,
            onTap: () => showLeaveReasonDialog(
              context,
              (reason) => context
                  .read<NewRequestBloc>()
                  .add(EnterRequestReason(reason)),
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
                  context.read<NewRequestBloc>().add(SelectFromDate(date)),
              title: 'Select From Date',
              disablePastDates: true,
              initialDate: state.fromDate,
            ),
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
              (date) => context.read<NewRequestBloc>().add(SelectToDate(date)),
              title: 'Select To Date',
              disablePastDates: true,
              initialDate: state.toDate,
            ),
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
              state.managers,
              (managers) =>
                  context.read<NewRequestBloc>().add(SelectManager(managers)),
            ),
          ),
          const SizedBox(height: 10),
          const Divider(color: AppColors.divider),
          const SizedBox(height: 10),
          _buildLeaveBalance(state.requestType),
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

  Widget _buildLeaveBalance(String leaveType) {
    return BlocBuilder<SessionBloc, SessionState>(
      builder: (context, session) {
        final m = session.leaveMatrices;
        return Row(
          children: [
            CircularStepProgressIndicator(
              totalSteps: m.allocated,
              currentStep: m.used,
              selectedColor: const Color(0XFF6170dc),
              unselectedColor: const Color(0xffbfb2e7),
              width: 50,
              height: 50,
              unselectedStepSize: 3,
              selectedStepSize: 3,
              roundedCap: (_, __) => true,
              child: Center(child: Text(m.percentage)),
            ),
            const SizedBox(width: 20),
            Text(
              "${m.used} / ${m.allocated} days remaining",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        );
      },
    );
  }
}
