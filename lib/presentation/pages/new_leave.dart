import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:manam_leave_management/core/utils/date_validator.dart';
import 'package:manam_leave_management/presentation/navigation/app_routes.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/font_family.dart';
import '../../core/utils/app_constants.dart';
import '../../core/utils/app_strings.dart';
import '../../core/utils/global_loader.dart';
import '../../core/utils/leave_type.dart';
import '../../core/utils/session_manager.dart';
import '../../core/utils/toast_helper.dart';
import '../../data/models/request/create_request_model.dart';
import '../../data/models/response/leave_model.dart';
import '../../di/injection_container.dart';
import '../bloc/request/new_request_bloc.dart';
import '../bloc/request/new_request_event.dart';
import '../bloc/request/new_request_state.dart';
import '../bloc/session/session_bloc.dart';
import '../widgets/date_picker_widget.dart';
import '../widgets/gradient_button.dart';
import '../widgets/leave_reason_dialog.dart';
import '../widgets/leave_selection_dialog.dart';
import '../widgets/management_selection_dialog.dart';
import '../widgets/status_dialog.dart';

class NewLeave extends StatelessWidget {
  /// If `existingLeave` is non-null, we’re in “edit” mode.
  final LeaveModel? existingLeave;

  const NewLeave({super.key, this.existingLeave});

  @override
  Widget build(BuildContext context) {
    // pick a default only if we’re creating for the first time
    final defaultType = LeaveType.casual.label;

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
            // If editing, dispatch the balance for the passed-in type; otherwise use default
            bloc.add(GetLeaveBalanceEvent(
              leaveType: existingLeave?.leaveType ?? defaultType,
            ));
            return bloc;
          },
        ),
      ],
      child: const NewLeaveView(),
    );
  }
}

class NewLeaveView extends StatelessWidget {
  final LeaveModel? existingLeave;

  const NewLeaveView({super.key, this.existingLeave});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<NewRequestBloc, NewRequestState>(
          listener: (context, state) {
            // whenever the requestType changes, refresh the balance
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
          // on success
          if (state.status == NewRequestStatus.success) {
            CustomStatusDialog.show(
              context: context,
              title: (existingLeave == null)
                  ? AppStrings.leaveApplied
                  : AppStrings.leaveUpdate,
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
          if (state.status == NewRequestStatus.failure) {
            print("NewLeaveStatusError: ${state.errorMessage}");
            ToastHelper.showErrorToast(
                state.errorMessage ?? 'Failed to apply request');
          }
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(bottom: 40, left: 20, right: 20),
              child: GradientButton(
                text: state.status == NewRequestStatus.submitting
                    ? 'Submitting…'
                    : 'Apply for ${state.duration} days Leave',
                textStyle: const TextStyle(
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16,
                ),
                onPressed: () {
                  final managerId = SessionManager()
                      .user!
                      .superiors
                      .firstWhere((s) => s.name == state.managers.first)
                      .id;

                  // build your CreateRequestParams here
                  final params = CreateRequestModel(
                      requestType: state.requestType.toUpperCase() +
                          (state.requestType.toLowerCase() == 'wfh'
                              ? ''
                              : '_LEAVE'),
                      fromDate: DateFormat(AppConstants.dateFormat1)
                          .format(state.fromDate),
                      toDate: DateFormat(AppConstants.dateFormat1)
                          .format(state.toDate),
                      reason: state.reason,
                      decidedBy: managerId);

                  // Now here you call this for edit only

                  if (existingLeave != null) {
                    if (existingLeave!.isEdit) {
                      context.read<NewRequestBloc>().add(UpdateRequest(
                          id: existingLeave!.id.toString(),
                          createRequestModel: params));
                    }
                  } else {
                    context
                        .read<NewRequestBloc>()
                        .add(SubmitRequest(createRequestModel: params));
                  }
                },
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _buildHeader(state, context),
                    const SizedBox(height: 20),
                    _buildForm(context, state),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(NewRequestState state, BuildContext context) {
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
          state.status == NewRequestStatus.edit
              ? AppStrings.updateLeave
              : AppStrings.newLeave,
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          _buildTile(
            icon: Icons.grid_view_rounded,
            title: AppStrings.type,
            value: state.requestType,
            onTap: () => showLeaveSelectionDialog(
              context,
              (type) {
                // update your form state
                context.read<NewRequestBloc>().add(SelectRequestType(type));
                // immediately update the leave-balance BLoC
                context
                    .read<SessionBloc>()
                    .add(GetLeaveBalanceEvent(leaveType: type));
              },
              initialType: state.requestType,
            ),
          ),
          const SizedBox(height: 10),
          const Divider(color: AppColors.divider),
          const SizedBox(height: 10),
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
              selectedColor: AppColors.gradient1,
              unselectedColor: Colors.grey.shade300,
              width: 50,
              height: 50,
              unselectedStepSize: 3,
              selectedStepSize: 3,
              roundedCap: (_, __) => true,
              child: Center(child: Text(m.percentage)),
            ),
            const SizedBox(width: 20),
            Text(m.leaveBalance, style: const TextStyle(fontSize: 16)),
          ],
        );
      },
    );
  }
}
