import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manam_leave_management/core/utils/app_strings.dart';

import '../../core/theme/app_colors.dart';

class LeaveReasonDialog extends StatefulWidget {
  final Function(String) onSubmit;
  final String? initialReason;

  const LeaveReasonDialog(
      {super.key, required this.onSubmit, this.initialReason});

  @override
  _LeaveReasonDialogState createState() => _LeaveReasonDialogState();
}

class _LeaveReasonDialogState extends State<LeaveReasonDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set the initial value if provided
    if (widget.initialReason != null) {
      _controller.text = widget.initialReason!;
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
        child: GestureDetector(
          onTap: () {}, // Prevent dialog dismissal
          child: CupertinoAlertDialog(
            title: const Text("Write Leave Reason"),
            content: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: _buildTextField(isCupertino: true),
            ),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Navigator.pop(context),
                child:
                    const Text("Cancel", style: TextStyle(color: Colors.red)),
              ),
              CupertinoDialogAction(
                onPressed: _submitReason,
                child: const Text("OK", style: TextStyle(color: Colors.blue)),
              ),
            ],
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
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Write Leave Reason",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            _buildTextField(isCupertino: false),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text("Cancel"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      // Important to let gradient container control the size
                      backgroundColor: Colors.transparent,
                      // Make the button background transparent
                      shadowColor: Colors.transparent,
                      // Remove shadow if you don't want default
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: _submitReason,
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.gradient1, AppColors.gradient2],
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
                          AppStrings.ok,
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
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({required bool isCupertino}) {
    return isCupertino
        ? CupertinoTextField(
            controller: _controller,
            placeholder: "Enter reason...",
            maxLines: 4,
            keyboardType: TextInputType.multiline,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          )
        : Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: TextField(
              controller: _controller,
              maxLines: 4,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                hintText: "Enter reason...",
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(12),
              ),
            ),
          );
  }

  void _submitReason() {
    if (_controller.text.isNotEmpty) {
      widget.onSubmit(_controller.text);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

/// Show function
void showLeaveReasonDialog(BuildContext context, Function(String) onSubmit,
    {String? initialReason}) {
  if (Platform.isIOS) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Dismiss",
      barrierColor: Colors.black54,
      pageBuilder: (_, __, ___) =>
          LeaveReasonDialog(onSubmit: onSubmit, initialReason: initialReason),
    );
  } else {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) =>
          LeaveReasonDialog(onSubmit: onSubmit, initialReason: initialReason),
    );
  }
}
