import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:manam_leave_management/core/utils/date_validator.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/font_family.dart';
import '../../core/utils/app_validators.dart';
import '../../core/utils/global_loader.dart';
import '../../domain/entities/holiday_entity.dart';
import '../bloc/holiday/holiday_bloc.dart';
import '../navigation/app_routes.dart';
import '../widgets/carousel_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  void initState() {
    super.initState();
    // trigger fetch
    context.read<HolidayBloc>().add(FetchAllHoliday());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HolidayBloc, HolidayState>(
      listener: (context, state) {
        if (state is HolidayLoading) {
          GlobalLoader.show();
        } else {
          GlobalLoader.hide();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              _buildGreetingHeader(context),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    showCalendar(),
                    const SizedBox(height: 20),
                    _buildHolidaySection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGreetingHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.gradient1, AppColors.gradient2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Calendar",
              style: TextStyle(
                  fontSize: 25,
                  fontFamily: FontFamily.poppins,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            Row(
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(24),
                    // Circular ripple
                    splashColor: Colors.white.withValues(alpha: 0.3),
                    // Customize splash color
                    highlightColor: Colors.white.withValues(alpha: 0.1),
                    // Customize highlight color
                    onTap: () {
                      AppRoutes.navigateTo(context, AppRoutes.notification);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(5.0), // Increase tap target size
                      child: Icon(Icons.notifications_rounded,
                          color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(
                      color: AppColors.gradient1.withValues(alpha: 0.5),
                      width: 3,
                    ),
                  ),
                  child: Center(
                    child: ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [AppColors.gradient1, AppColors.gradient2],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds),
                      child: Text(
                        AppValidators.getInitial(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          fontFamily: FontFamily.poppins,
                          color: Colors.white,
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

  Widget showCalendar() {
    return CarouselCalendar(
      markedDates: {
        DateTime(2025, 05, 8),
        DateTime(2025, 05, 11),
        DateTime(2025, 07, 17),
        DateTime(2025, 08, 21),
        DateTime(2025, 09, 22),
      },
    );
  }

  Widget _buildHolidaySection() {
    return BlocBuilder<HolidayBloc, HolidayState>(
      builder: (context, state) {
        if (state is HolidayInitialFailure) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Center(child: Text("Error: ${state.message}")),
          );
        } else if (state is HolidaySuccess) {
          return _buildHolidayTable(state.data);
        }
        // while loading or initial, just return empty space
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildHolidayTable(List<HolidayEntity> holidays) {
    final DateFormat dateFmt = DateFormat('MMM dd');
    final DateFormat dayFmt = DateFormat('EEE');

    return Container(
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 50,
      ),
      child: Card(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              "List of Holidays ${DateValidator.getCurrentYear()}",
              style: const TextStyle(
                fontSize: 25,
                fontFamily: FontFamily.poppins,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 35,
                headingRowColor: WidgetStateProperty.resolveWith(
                    (_) => Colors.grey.shade200),
                columns: const [
                  DataColumn(label: Text('Sl.No.')),
                  DataColumn(label: Text('Holiday')),
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Day')),
                ],
                rows: List.generate(holidays.length, (i) {
                  final h = holidays[i];
                  // parse "dd-MM-yyyy"
                  final dt = DateFormat('dd-MM-yyyy').parse(h.holidayDate);
                  return DataRow(cells: [
                    DataCell(Text('${i + 1}')),
                    DataCell(Text(h.holidayName)),
                    DataCell(Text(dateFmt.format(dt))),
                    DataCell(Text(dayFmt.format(dt))),
                  ]);
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
