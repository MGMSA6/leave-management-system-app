import 'package:intl/intl.dart';
import 'package:manam_leave_management/core/utils/app_constants.dart';

class DateValidator {
  static String formatDuration(int? days) =>
      (days ?? 1) == 1 ? "1 Day Application" : "$days Days Application";

  static String convertMinutesToHours(int durationMinutes) {
    int hours = durationMinutes ~/ 60; // Divide by 60 to get hours
    int minutes = durationMinutes % 60; // Get the remaining minutes

    // Return the result in "X hrs Y mins" format
    return "$hours hr ${minutes}min";
  }

  static DateTime parseDate(String date) {
    DateFormat dateFormat = DateFormat("dd-MM-yyyy");
    return dateFormat.parse(date);
  }

  static String formatTime(String dateTime) {
    // Define the input format: "dd-MM-yyyy HH:mm:ss"
    DateFormat inputFormat = DateFormat("dd-MM-yyyy HH:mm:ss");

    // Parse the given date string to a DateTime object
    DateTime parsedDate = inputFormat.parse(dateTime);

    // Define the output format: "hh:mm a" (12-hour format with AM/PM)
    DateFormat outputFormat = DateFormat("h:mm a");

    // Format the parsed date and return the formatted time
    String formattedTime = outputFormat.format(parsedDate);

    return formattedTime;
  }

  static String _monthName(String month) {
    const months = [
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
    return months[int.parse(month) - 1];
  }

  // Helper to format the month-year string
  static String _formatMonthYear(String monthKey) {
    final parts = monthKey.split('-');
    final year = parts[0];
    final month = parts[1];
    return "${DateValidator.monthName(month)} $year";
  }

  static String formatMonthYear(String monthKey) {
    final parts = monthKey.split('-');
    final year = parts[0];
    final month = parts[1];
    return "${_monthName(month)} $year";
  }

  static String monthName(String month) {
    switch (month) {
      case '01':
        return 'January';
      case '02':
        return 'February';
      case '03':
        return 'March';
      case '04':
        return 'April';
      case '05':
        return 'May';
      case '06':
        return 'June';
      case '07':
        return 'July';
      case '08':
        return 'August';
      case '09':
        return 'September';
      case '10':
        return 'October';
      case '11':
        return 'November';
      case '12':
        return 'December';
      default:
        return '';
    }
  }

  static String formatDate(String date) {
    // Check if the date contains time
    DateFormat dateFormat;
    if (date.contains(":")) {
      // Input contains time, use the full format with time
      dateFormat = DateFormat("dd-MM-yyyy HH:mm:ss");
    } else {
      // Input only has date, use the simpler format
      dateFormat = DateFormat("dd-MM-yyyy");
    }

    // Parse the date string
    DateTime parsedDate = dateFormat.parse(date);

    // Define the desired output format for display
    DateFormat outputFormat = DateFormat("EEE, dd MMM");

    // Format the parsed date
    String formattedDate = outputFormat.format(parsedDate);

    return formattedDate;
  }

  static String getCurrentYear() {
    return DateTime.now().year.toString();
  }

  static DateTime convertStringToDateTime(String dateString) {
    return DateFormat(AppConstants.timeFormat).parse(dateString);
  }


  static int daysBetween(DateTime from, DateTime to) {
    final diff = to.difference(from).inDays + 1;
    return diff > 0 ? diff : 1;
  }

  static String formatDate1(DateTime? d) =>
      d == null ? '' : DateFormat('EEE, dd MMM').format(d);

  static String formatTime1(DateTime? d) =>
      d == null ? '' : DateFormat('hh:mm a').format(d);
}




