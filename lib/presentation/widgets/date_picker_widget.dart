import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class DatePickerWidget extends StatefulWidget {
  final String title;
  final Function(DateTime) onDateSelected;
  final bool disablePastDates;
  final DateTime? initialDate;

  const DatePickerWidget({
    super.key,
    required this.onDateSelected,
    this.title = "Select Date",
    this.disablePastDates = true,
    this.initialDate,
  });

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime? _selectedDate;

  // Controllers for the list views
  late FixedExtentScrollController _monthController;
  late FixedExtentScrollController _dayController;
  late FixedExtentScrollController _yearController;

  // Lists for months, days, and years
  final List<String> _months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  final List<int> _days = List.generate(31, (index) => index + 1);
  late List<int> _years;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? DateTime.now();

    // Setup year range (100 years back and 50 years in future)
    final currentYear = DateTime.now().year;
    _years = List.generate(150, (index) => currentYear - 100 + index);

    // Initialize controllers to the correct positions
    _monthController =
        FixedExtentScrollController(initialItem: _selectedDate!.month - 1);
    _dayController =
        FixedExtentScrollController(initialItem: _selectedDate!.day - 1);
    _yearController = FixedExtentScrollController(
        initialItem: _years.indexOf(_selectedDate!.year));
  }

  @override
  void dispose() {
    _monthController.dispose();
    _dayController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      // iOS Cupertino DatePicker
      return CupertinoAlertDialog(
        title: Text(widget.title),
        content: SizedBox(
          height: 200,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: widget.initialDate ?? DateTime.now(),
            minimumDate: widget.disablePastDates
                ? DateTime(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day)
                : null,
            onDateTimeChanged: (DateTime newDate) {
              setState(() {
                _selectedDate = newDate;
              });
            },
          ),
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text("Cancel", style: TextStyle(color: Colors.red)),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            child: const Text("OK", style: TextStyle(color: Colors.blue)),
            onPressed: () {
              if (_selectedDate != null) {
                widget.onDateSelected(_selectedDate!);
              }
              Navigator.pop(context);
            },
          ),
        ],
      );
    } else {
      // Custom Android wheel-style picker
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.title.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              Container(
                height: 200,
                child: Row(
                  children: [
                    // Month picker
                    Expanded(
                      child: _buildPickerColumn(
                        controller: _monthController,
                        items: _months,
                        onSelectedItemChanged: (index) {
                          setState(() {
                            final newMonth = index + 1;
                            final oldDate = _selectedDate!;
                            // Adjust day if it exceeds the max for the new month
                            final maxDays =
                                _daysInMonth(newMonth, oldDate.year);
                            final newDay =
                                oldDate.day > maxDays ? maxDays : oldDate.day;

                            _selectedDate =
                                DateTime(oldDate.year, newMonth, newDay);

                            // Update day controller if day changed
                            if (newDay != oldDate.day) {
                              _dayController.jumpToItem(newDay - 1);
                            }
                          });
                        },
                      ),
                    ),
                    // Day picker
                    Expanded(
                      child: _buildPickerColumn(
                        controller: _dayController,
                        items: _days.map((day) => day.toString()).toList(),
                        onSelectedItemChanged: (index) {
                          setState(() {
                            _selectedDate = DateTime(_selectedDate!.year,
                                _selectedDate!.month, index + 1);
                          });
                        },
                      ),
                    ),
                    // Year picker
                    Expanded(
                      child: _buildPickerColumn(
                        controller: _yearController,
                        items: _years.map((year) => year.toString()).toList(),
                        onSelectedItemChanged: (index) {
                          setState(() {
                            final newYear = _years[index];
                            final oldDate = _selectedDate!;
                            // Check if we need to adjust the day for leap years
                            final maxDays =
                                _daysInMonth(oldDate.month, newYear);
                            final newDay =
                                oldDate.day > maxDays ? maxDays : oldDate.day;

                            _selectedDate =
                                DateTime(newYear, oldDate.month, newDay);

                            // Update day controller if day changed
                            if (newDay != oldDate.day) {
                              _dayController.jumpToItem(newDay - 1);
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  SizedBox(
                    width: 10,
                  ),
// Vivek
// 8668867624
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
                      onPressed: () {
                        if (_selectedDate != null) {
                          widget.onDateSelected(_selectedDate!);
                        }
                        Navigator.pop(context);
                      },
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
                  // Cancel button
                ],
              )
            ],
          ),
        ),
      );
    }
  }

  // Helper method to build a picker column
  Widget _buildPickerColumn({
    required FixedExtentScrollController controller,
    required List<String> items,
    required Function(int) onSelectedItemChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.shade300),
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: ListWheelScrollView.useDelegate(
        controller: controller,
        itemExtent: 40,
        physics: const FixedExtentScrollPhysics(),
        perspective: 0.005,
        diameterRatio: 1.5,
        onSelectedItemChanged: onSelectedItemChanged,
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: items.length,
          builder: (context, index) {
            return Center(
              child: Text(
                items[index],
                style: TextStyle(
                  fontSize: 20,
                  color: controller.selectedItem == index
                      ? Colors.black
                      : Colors.grey,
                  fontWeight: controller.selectedItem == index
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Helper method to get the number of days in a month
  int _daysInMonth(int month, int year) {
    return DateTime(year, month + 1, 0).day;
  }
}

// Keep your showDatePickerDialog function unchanged
void showDatePickerDialog(
  BuildContext context,
  Function(DateTime) onDateSelected, {
  String title = "Select Date",
  bool disablePastDates = true,
  DateTime? initialDate,
}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Dismiss",
    pageBuilder: (context, _, __) => DatePickerWidget(
      onDateSelected: onDateSelected,
      title: title,
      disablePastDates: disablePastDates,
      initialDate: initialDate,
    ),
  );
}
