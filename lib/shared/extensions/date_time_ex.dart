import 'package:flutter/material.dart';

extension DateTimeEx on DateTime {
  bool get isMorning {
    return hour >= 6 && hour < 12;
  }

  String toDmy() {
    // Format the day, month, and year to 'DD-MM-YYYY'
    String day = this.day.toString().padLeft(2, '0'); // Ensures two digits for the day
    String month = this.month.toString().padLeft(2, '0'); // Ensures two digits for the month
    String year = this.year.toString(); // No padding required for the year

    return '$year-$month-$day';
  }

  String toDM() {
    // Format the day, month, and year to 'DD-MM-YYYY'
    String day = this.day.toString().padLeft(2, '0'); // Ensures two digits for the day
    String month = this.month.toString().padLeft(2, '0'); // Ensures two digits for the month

    return '$month-$day';
  }

  /// Checks if the current time is within the given time range (inclusive).
  ///
  /// The start and end times are given in 'HH:mm' format.
  /// The comparison is done with the current time in the device's local time.
  bool inTimeRange(String startTime, String endTime) {
    // Parse current time
    final now = this;
    final currentTime = TimeOfDay(hour: now.hour, minute: now.minute);

    // Parse start and end times
    final start = parseTimeString(startTime);
    final end = parseTimeString(endTime);

    if (end.isBefore(start)) {
      // Current time is either after start OR before end
      return currentTime.hour > start.hour ||
          (currentTime.hour == start.hour && currentTime.minute >= start.minute) ||
          currentTime.hour < end.hour ||
          (currentTime.hour == end.hour && currentTime.minute < end.minute);
    } else {
      // Normal range within the same day
      return (currentTime.hour > start.hour || (currentTime.hour == start.hour && currentTime.minute >= start.minute)) &&
          (currentTime.hour < end.hour || (currentTime.hour == end.hour && currentTime.minute < end.minute));
    }
  }

  TimeOfDay parseTimeString(String timeString) {
    final parts = timeString.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }
}

extension DateTimeEx2 on String {
  /// Converts a time string in 'HH:mm' format to 'h:mm AM/PM' format.
  ///
  /// Example: '14:30' converts to '2:30 PM'
  String toAmPm() {
    try {
      final parts = split(':');
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);

      final amPm = hour < 12 ? 'AM' : 'PM';
      final formattedHour = hour == 0
          ? 12
          : hour > 12
              ? hour - 12
              : hour;
      final formattedMinute = minute.toString().padLeft(2, '0');

      return '$formattedHour:$formattedMinute$amPm';
    } catch (e) {
      return this;
    }
  }
}
