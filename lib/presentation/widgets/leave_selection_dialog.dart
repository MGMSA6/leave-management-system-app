import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/leave_type.dart';
import '../bloc/request/new_request_bloc.dart';
import '../bloc/request/new_request_event.dart';

class LeaveSelectionDialog extends StatefulWidget {
  final Function(String) onSelect;
  final String? initialSelection;

  const LeaveSelectionDialog({
    super.key,
    required this.onSelect,
    this.initialSelection,
  });

  @override
  _LeaveSelectionDialogState createState() => _LeaveSelectionDialogState();
}

class _LeaveSelectionDialogState extends State<LeaveSelectionDialog> {
  int? selectedIndex;

  static const Color gradient1 = Color(0XFF9969d1);
  static const Color gradient2 = Color(0XFF5d71dd);

  final List<Map<String, dynamic>> leaveOptions = [
    {"text": LeaveType.sick.label, "icon": Icons.local_hospital},
    {"text": LeaveType.casual.label, "icon": Icons.weekend},
    // {"text": LeaveType.probationary.label, "icon": Icons.verified_user},
    // {"text": LeaveType.unplanned.label, "icon": Icons.error_outline},
    // {"text": LeaveType.maternity.label, "icon": Icons.pregnant_woman},
    // {"text": LeaveType.paternity.label, "icon": Icons.family_restroom},
  ];

  @override
  void initState() {
    super.initState();

    if (widget.initialSelection != null) {
      final initialLower = widget.initialSelection!.toLowerCase().trim();

      for (int i = 0; i < leaveOptions.length; i++) {
        final optionTextLower = (leaveOptions[i]["text"] as String).toLowerCase();
        if (optionTextLower == initialLower) {
          selectedIndex = i;
          break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? _buildCupertinoDialog() : _buildMaterialDialog();
  }

  Widget _buildCupertinoDialog() {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        color: Colors.black.withValues(alpha: 0.2),
        // Fixed withValues to withOpacity
        child: GestureDetector(
          onTap: () {},
          child: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: CupertinoAlertDialog(
                title: const Text("Select Leave Type"),
                content: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: _buildLeaveGrid(),
                ),
                actions: [
                  CupertinoDialogAction(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel",
                        style: TextStyle(color: Colors.red)),
                  ),
                  CupertinoDialogAction(
                    onPressed: _onSelectPressed,
                    child: const Text("Select",
                        style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMaterialDialog() {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10)],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Select Leave Type",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            _buildLeaveGrid(),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: _onSelectPressed,
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [gradient1, gradient2],
                          // Using class constants
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 24),
                        child: const Text(
                          "Select",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaveGrid() {
    return GridView.builder(
      // allow the grid to be only as tall as its content
      shrinkWrap: true,
      // disable inner scrolling so the dialog handles overflow
      physics: const NeverScrollableScrollPhysics(),
      itemCount: leaveOptions.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: Platform.isIOS ? 1.4 : 1.7,
      ),
      itemBuilder: (context, index) {
        final option = leaveOptions[index];
        final isSelected = selectedIndex == index;

        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => setState(() => selectedIndex = index),
            borderRadius: BorderRadius.circular(12),
            splashColor: gradient1.withOpacity(0.1),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? Colors.blue : Colors.grey[300]!,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [gradient1, gradient2],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    blendMode: BlendMode.srcIn,
                    child: Icon(option["icon"], size: 28),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    option["text"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _onSelectPressed() {
    if (selectedIndex != null) {
      String selectedLeave = leaveOptions[selectedIndex!]["text"];
      context.read<NewRequestBloc>().add(SelectRequestType(selectedLeave));
      widget.onSelect(selectedLeave);
      Navigator.pop(context);
    }
  }
}

/// Call this function to show the dialog
void showLeaveSelectionDialog(BuildContext context, Function(String) onSelect,
    {String? initialType}) {
  if (Platform.isIOS) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Dismiss",
      barrierColor: Colors.black54,
      pageBuilder: (_, __, ___) => LeaveSelectionDialog(
          onSelect: onSelect, initialSelection: initialType),
    );
  } else {
    showDialog(
      context: context,
      builder: (_) => LeaveSelectionDialog(
          onSelect: onSelect, initialSelection: initialType),
    );
  }
}
