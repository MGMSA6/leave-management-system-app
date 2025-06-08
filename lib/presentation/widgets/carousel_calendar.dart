// carousel_calendar.dart

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../core/theme/app_colors.dart';

class CarouselCalendar extends StatefulWidget {
  final Set<DateTime> markedDates;

  const CarouselCalendar({
    super.key,
    this.markedDates = const {},
  });

  @override
  State<CarouselCalendar> createState() => _CarouselCalendarState();
}

class _CarouselCalendarState extends State<CarouselCalendar> {
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () {
                  setState(() {
                    _focusedDay = DateTime(
                      _focusedDay.year,
                      _focusedDay.month - 1,
                      1,
                    );
                  });
                },
              ),
              Column(
                children: [
                  Text(
                    "${_monthName(_focusedDay.month)} ${_focusedDay.year}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () {
                  setState(() {
                    _focusedDay = DateTime(
                      _focusedDay.year,
                      _focusedDay.month + 1,
                      1,
                    );
                  });
                },
              ),
            ],
          ),
        ),

        // --- The calendar itself ---
        TableCalendar(
          firstDay: DateTime.utc(2000, 1, 1),
          lastDay: DateTime.utc(2100, 12, 31),
          focusedDay: _focusedDay,
          headerVisible: false,
          calendarFormat: CalendarFormat.month,
          availableGestures: AvailableGestures.horizontalSwipe,
          onPageChanged: (newFocused) {
            setState(() {
              _focusedDay = newFocused;
            });
          },

          // highlight your markedDates by returning a non‐empty list here:
          eventLoader: (date) =>
              widget.markedDates.contains(_stripTime(date)) ? [date] : [],

          calendarBuilders: CalendarBuilders(
            // here we draw our gradient marker under the day number
            markerBuilder: (context, date, events) {
              if (events.isEmpty) return const SizedBox();
              return Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [AppColors.gradient1, AppColors.gradient2],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '${date.day}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          // day styling
          calendarStyle: const CalendarStyle(
            outsideDaysVisible: false,
            todayDecoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
            ),
            selectedDecoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }

  DateTime _stripTime(DateTime dt) => DateTime(dt.year, dt.month, dt.day);

  String _monthName(int m) {
    const names = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return names[m - 1];
  }
}
