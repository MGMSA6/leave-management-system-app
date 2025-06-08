import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/theme/font_family.dart';

class ConfirmActionDialog extends StatelessWidget {
  final String title;
  final String description;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;
  final bool isDestructive;

  const ConfirmActionDialog({
    super.key,
    required this.title,
    required this.description,
    required this.confirmText,
    required this.cancelText,
    required this.onConfirm,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        title: Text(
          title,
          style: TextStyle(
            color: isDestructive ? Colors.red : Colors.black,
            fontFamily: FontFamily.poppins,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(description),
        actions: [
          CupertinoDialogAction(
            child: Text(cancelText),
            onPressed: () => Navigator.of(context).pop(),
          ),
          CupertinoDialogAction(
            isDestructiveAction: isDestructive,
            child: Text(confirmText),
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm();
            },
          ),
        ],
      );
    } else {
      return AlertDialog(
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: FontFamily.poppins,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          description,
          style: const TextStyle(
            fontFamily: FontFamily.poppins,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          TextButton(
            child: Text(cancelText),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor:
                  isDestructive ? Colors.red : Theme.of(context).primaryColor,
            ),
            child: Text(confirmText),
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm();
            },
          ),
        ],
      );
    }
  }
}

void showConfirmDialog({
  required BuildContext context,
  required String title,
  required String description,
  required String confirmText,
  required String cancelText,
  required VoidCallback onConfirm,
  bool isDestructive = false,
}) {
  final dialog = ConfirmActionDialog(
    title: title,
    description: description,
    confirmText: confirmText,
    cancelText: cancelText,
    onConfirm: onConfirm,
    isDestructive: isDestructive,
  );

  if (Platform.isIOS) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => dialog,
    );
  } else {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => dialog,
    );
  }
}
