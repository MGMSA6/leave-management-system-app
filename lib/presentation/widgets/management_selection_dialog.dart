import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manam_leave_management/core/utils/app_strings.dart';
import 'package:manam_leave_management/core/utils/toast_helper.dart';

import '../../core/theme/font_family.dart';
import '../../core/utils/session_manager.dart';

class ManagementSelectionDialog extends StatefulWidget {
  final Function(List<String>) onSelect;
  final List<String> initialSelected;

  const ManagementSelectionDialog({
    super.key,
    required this.onSelect,
    required this.initialSelected,
  });

  @override
  State<ManagementSelectionDialog> createState() =>
      _ManagementSelectionDialogState();
}

class _ManagementSelectionDialogState extends State<ManagementSelectionDialog> {
  late List<String> selectedNames;
  late List<Map<String, dynamic>> managementOptions;

  void _populateManagementOptions() {
    final user = SessionManager().user!;
    managementOptions = user.superiors.map((superior) {
      return {
        "name": superior.name,
        "id": superior.id,
        "icon": Icons.person,
      };
    }).toList();
  }

  @override
  void initState() {
    super.initState();

    selectedNames = List<String>.from(widget.initialSelected);
    _populateManagementOptions();
  }

  void toggleSelection(String name) {
    setState(() {
      if (selectedNames.contains(name)) {
        selectedNames.remove(name);
      } else {
        selectedNames.add(name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? _buildCupertinoDialog(context)
        : _buildMaterialDialog(context);
  }

  Widget _buildCupertinoDialog(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text(
        "Select Manager",
        style: TextStyle(
          fontFamily: FontFamily.poppins,
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
      ),
      content: StatefulBuilder(
        builder: (context, innerSetState) {
          return CupertinoScrollbar(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: managementOptions.length,
              itemBuilder: (context, index) {
                final option = managementOptions[index];
                final name = option["name"] as String; // e.g. "Faizan"
                final isSelected = selectedNames.contains(name);

                return CupertinoListTile(
                  name: name,
                  icon: option["icon"] as IconData,
                  isSelected: isSelected,
                  onTap: () => innerSetState(() => toggleSelection(name)),
                );
              },
            ),
          );
        },
      ),
      actions: [
        CupertinoDialogAction(
          isDestructiveAction: true,
          child: const Text("Cancel"),
          onPressed: () => Navigator.pop(context),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          child: const Text(
            "Select",
            style: TextStyle(color: Colors.blue),
          ),
          onPressed: () {
            if (selectedNames.isEmpty) {
              ToastHelper.showToast(AppStrings.atLeastOneManagerRequired);
              return;
            }

            // You may want to convert these first‐names back into full names
            // before calling onSelect, but if your BLoC only needs first names,
            // you can send them directly:
            widget.onSelect(selectedNames);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  Widget _buildMaterialDialog(BuildContext context) {
    const Color gradient1 = Color(0XFF9969d1);
    const Color gradient2 = Color(0XFF5d71dd);

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
              "Select Manager",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                fontFamily: FontFamily.poppins,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // Wrap the ListView in Flexible if you expect many items:
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: managementOptions.length,
                itemBuilder: (context, index) {
                  final option = managementOptions[index];
                  final name = option["name"] as String; // e.g. "Faizan"
                  final isSelected = selectedNames.contains(name);

                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!, width: 1),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 12),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.blueAccent,
                          child: Icon(option["icon"] as IconData,
                              color: Colors.white),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: FontFamily.poppins,
                            ),
                          ),
                        ),
                        Checkbox(
                          value: isSelected,
                          onChanged: (_) =>
                              setState(() => toggleSelection(name)),
                          activeColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.red, width: 1),
                      ),
                      child: const Center(
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            fontFamily: FontFamily.poppins,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      if (selectedNames.isEmpty) {
                        ToastHelper.showToast(
                            AppStrings.atLeastOneManagerRequired);
                        return;
                      }
                      widget.onSelect(selectedNames);
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      margin: const EdgeInsets.only(left: 8),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [gradient1, gradient2],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: gradient2.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          "Select",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            fontFamily: FontFamily.poppins,
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
}

/// Helper widget to build a Cupertino-style list tile
class CupertinoListTile extends StatelessWidget {
  final String name;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const CupertinoListTile({
    super.key,
    required this.name,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: CupertinoColors.systemGrey4, width: 1),
        borderRadius: BorderRadius.circular(8),
        color: CupertinoColors.white,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: CupertinoColors.activeBlue,
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontFamily: FontFamily.poppins,
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: Checkbox(
                value: isSelected,
                onChanged: (_) => onTap(),
                activeColor: CupertinoColors.activeBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showManagementSelectionDialog(
  BuildContext context,
  List<String> initialSelected,
  Function(List<String>) onSelect,
) {
  if (Platform.isIOS) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => ManagementSelectionDialog(
        onSelect: onSelect,
        initialSelected: initialSelected,
      ),
    );
  } else {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => ManagementSelectionDialog(
        onSelect: onSelect,
        initialSelected: initialSelected,
      ),
    );
  }
}
