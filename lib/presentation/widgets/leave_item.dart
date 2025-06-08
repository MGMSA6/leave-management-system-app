import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manam_leave_management/presentation/bloc/request/new_request_bloc.dart';
import 'package:manam_leave_management/presentation/navigation/app_routes.dart';
import 'package:manam_leave_management/presentation/pages/new_wfh.dart';

import '../../core/utils/date_validator.dart';
import '../../data/models/response/leave_model.dart';
import '../bloc/request/new_request_event.dart';
import '../pages/new_leave.dart';
import 'confirm_action_dialog.dart';

class LeaveItem extends StatefulWidget {
  final int id;
  final int? duration;
  final String date;
  final String reason;
  final String status;
  final String leaveType;
  final DateTime fromDate;
  final DateTime toDate;
  final List<String> managers;
  final int totalDays;
  final bool hideLeaveType;

  const LeaveItem(
      {super.key,
      required this.id,
      required this.duration,
      required this.date,
      required this.reason,
      required this.status,
      required this.leaveType,
      required this.fromDate,
      required this.toDate,
      required this.managers,
      required this.totalDays,
      required this.hideLeaveType});

  @override
  State<LeaveItem> createState() => _LeaveItemState();
}

class _LeaveItemState extends State<LeaveItem> {
  bool isExpanded = false;

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green.shade100;
      case 'pending':
        return Colors.yellow.shade100;
      case 'rejected':
        return Colors.red.shade100;
      default:
        return Colors.grey.shade200;
    }
  }

  Color getStatusTextColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green.shade700;
      case 'pending':
        return Colors.orange.shade800;
      case 'rejected':
        return Colors.red.shade700;
      default:
        return Colors.grey.shade800;
    }
  }

  IconData getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Icons.check_circle;
      case 'pending':
        return Icons.access_time_filled_rounded;
      case 'rejected':
        return Icons.cancel;
      default:
        return Icons.info_outline;
    }
  }

  bool get shouldShowEditButton =>
      isExpanded && widget.status.toLowerCase() == 'pending';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // LEFT SIDE DETAILS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Duration + leave type tag
                Row(
                  children: [
                    Text(
                      DateValidator.formatDuration(widget.duration),
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 5),
                    if (!widget.hideLeaveType)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "${widget.leaveType} Leave",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.deepPurple.shade700,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  widget.date,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),

                // Expandable reason
                AnimatedSize(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: Text(
                      widget.reason,
                      maxLines: isExpanded ? null : 1,
                      overflow: isExpanded
                          ? TextOverflow.visible
                          : TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.deepPurple.shade400,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // RIGHT SIDE
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: getStatusColor(widget.status),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      getStatusIcon(widget.status),
                      size: 16,
                      color: getStatusTextColor(widget.status),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      widget.status,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: getStatusTextColor(widget.status),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Material(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  splashColor: Colors.grey.shade300,
                  onTap: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_down_rounded
                          : Icons.keyboard_arrow_right_rounded,
                      size: 20,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Conditionally show Edit button
              if (shouldShowEditButton)
                Row(
                  children: [
                    Material(
                      color: Colors.transparent,
                      shape: const CircleBorder(),
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: () {
                          showConfirmDialog(
                            context: context,
                            title: "Delete Request",
                            description:
                                "Are you sure you want to delete this request?",
                            confirmText: "Delete",
                            cancelText: "Cancel",
                            isDestructive: true,
                            onConfirm: () {
                              context
                                  .read<NewRequestBloc>()
                                  .add(DeleteRequest(id: widget.id.toString()));
                            },
                          );
                        },
                        customBorder: const CircleBorder(),
                        splashColor: Colors.grey.shade400,
                        highlightColor: Colors.grey.shade300,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.red.shade800, width: 2),
                          ),
                          child: Icon(
                            Icons.cancel_rounded,
                            color: Colors.red.shade800,
                            size: 15,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Material(
                      color: Colors.transparent,
                      shape: const CircleBorder(),
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: () {
                          // Dispatch the update event to preload data

                          final leaveToEdit = LeaveModel(
                            id: widget.id,
                            leaveType: widget.leaveType,
                            reason: widget.reason,
                            fromDate: widget.fromDate,
                            toDate: widget.toDate,
                            managers: widget.managers,
                            duration: widget.duration,
                            status: widget.status,
                            isEdit: true,
                          );

                          if (widget.leaveType == "WFH") {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    NewWFH(existingLeave: leaveToEdit),
                              ),
                            );
                          } else {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    NewLeave(existingLeave: leaveToEdit),
                              ),
                            );
                          }
                        },
                        customBorder: const CircleBorder(),
                        splashColor: Colors.grey.shade400,
                        highlightColor: Colors.grey.shade300,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.yellow.shade800, width: 2),
                          ),
                          child: Icon(
                            Icons.edit_rounded,
                            color: Colors.yellow.shade800,
                            size: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
