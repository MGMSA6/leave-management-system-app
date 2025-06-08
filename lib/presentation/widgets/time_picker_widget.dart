import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_colors.dart';

class TimePickerWidget extends StatefulWidget {
  final String title;
  final Function(DateTime) onTimeSelected;
  final DateTime? initialTime;

  const TimePickerWidget({
    super.key,
    required this.onTimeSelected,
    this.title = "Select Time",
    this.initialTime,
  });

  @override
  _TimePickerWidgetState createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  late int selectedHour;
  late int selectedMinute;
  late bool isAm;

  @override
  void initState() {
    super.initState();
    final now = TimeOfDay.fromDateTime(widget.initialTime ?? DateTime.now());
    selectedHour = now.hourOfPeriod == 0 ? 12 : now.hourOfPeriod;
    selectedMinute = now.minute;
    isAm = now.period == DayPeriod.am;
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        title: Text(DateFormat('hh:mm a').format(DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          isAm ? selectedHour % 12 : (selectedHour % 12) + 12,
          selectedMinute,
        ))),
        content: SizedBox(
          height: 200,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.time,
            initialDateTime: DateTime(
              2024,
              1,
              1,
              isAm ? selectedHour % 12 : (selectedHour % 12) + 12,
              selectedMinute,
            ),
            use24hFormat: false,
            onDateTimeChanged: (dateTime) {
              setState(() {
                int hour = dateTime.hour;
                selectedHour = hour == 0 || hour == 12 ? 12 : hour % 12;
                selectedMinute = dateTime.minute;
                isAm = hour < 12;
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
              final int finalHour =
                  isAm ? selectedHour % 12 : (selectedHour % 12) + 12;
              final now = DateTime.now();
              final selectedDateTime = DateTime(
                  now.year, now.month, now.day, finalHour, selectedMinute);
              widget.onTimeSelected(selectedDateTime);
              Navigator.pop(context);
            },
          ),
        ],
      );
    } else {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Text('Hour',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Minute',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('AM/PM',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 180, // Give height only to the wheel row
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildWheel(
                            items: List.generate(
                                12,
                                (index) =>
                                    (index + 1).toString().padLeft(2, '0')),
                            selected: selectedHour - 1,
                            onSelected: (index) {
                              setState(() {
                                selectedHour = index + 1;
                              });
                            },
                          ),
                        ),
                        const Text(":",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                        Expanded(
                          child: _buildWheel(
                            items: List.generate(60,
                                (index) => index.toString().padLeft(2, '0')),
                            selected: selectedMinute,
                            onSelected: (index) {
                              setState(() {
                                selectedMinute = index;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: _buildWheel(
                            items: ['AM', 'PM'],
                            selected: isAm ? 0 : 1,
                            onSelected: (index) {
                              setState(() {
                                isAm = index == 0;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
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
                            borderRadius: BorderRadius.circular(25)),
                      ),
                      onPressed: () {
                        final int finalHour =
                            isAm ? selectedHour % 12 : (selectedHour % 12) + 12;
                        final now = DateTime.now();
                        final selectedDateTime = DateTime(now.year, now.month,
                            now.day, finalHour, selectedMinute);
                        widget.onTimeSelected(selectedDateTime);
                        Navigator.pop(context);
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppColors.gradient1, AppColors.gradient2],
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 24),
                          child: const Text("Select",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15)),
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

  Widget _buildWheel({
    required List<String> items,
    required int selected,
    required Function(int) onSelected,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.shade300),
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: ListWheelScrollView.useDelegate(
        itemExtent: 40,
        diameterRatio: 1.5,
        perspective: 0.005,
        controller: FixedExtentScrollController(initialItem: selected),
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: onSelected,
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: items.length,
          builder: (context, index) => Center(
            child: Text(
              items[index],
              style: TextStyle(
                fontSize: 20,
                fontWeight:
                    selected == index ? FontWeight.bold : FontWeight.normal,
                color: selected == index ? Colors.black : Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void showTimePickerDialog(
  BuildContext context,
  Function(DateTime) onTimeSelected, {
  String title = "Select Time",
  DateTime? initialTime,
}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Dismiss",
    pageBuilder: (context, _, __) => TimePickerWidget(
      onTimeSelected: onTimeSelected,
      title: title,
      initialTime: initialTime,
    ),
  );
}
