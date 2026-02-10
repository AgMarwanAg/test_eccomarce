import 'package:easy_localization/easy_localization.dart';

import '../../core/di/locator.dart';
import '../../core/localization/localization_service.dart';

/// Extension on [DateTime] to provide a human-readable "time ago" functionality.
/// It returns the time difference between the current time and the provided timestamp,
/// formatted into a user-friendly string like "5 minutes ago" or "2 hours ago".
///
/// The position of "ago" changes based on the locale:
/// - In Arabic (`ar`), "ago" is placed at the beginning, e.g., "منذ 5 دقائق".
/// - In other languages, "ago" is placed at the end, e.g., "5 minutes ago".
extension TimeAgoEx on DateTime {
  /// Returns a human-readable "time ago" string based on the time difference from the current time.
  /// Example: "5 minutes ago", "2 hours ago", etc.
  ///
  /// Uses [formatTime] to determine the appropriate time unit (seconds, minutes, hours, etc.)
  /// and handle localization based on the current language (using EasyLocalization).
  String get timeAgo => formatTime(millisecondsSinceEpoch);

  /// Formats the given [timestamp] (in milliseconds) into a human-readable, localized string.
  /// Automatically chooses the appropriate unit (seconds, minutes, etc.) and "ago" placement.
  String formatTime(int timestamp) {
    final now = DateTime.now().millisecondsSinceEpoch;
    final difference = now - timestamp;
    String result;

    if (difference < 60000) {
      result = DateTimeHelper._countSeconds(difference);
    } else if (difference < 3600000) {
      result = DateTimeHelper._countMinutes(difference);
    } else if (difference < 86400000) {
      result = DateTimeHelper._countHours(difference);
    } else if (difference < 604800000) {
      result = DateTimeHelper._countDays(difference);
    } else if (difference / 1000 < 2419200) {
      result = DateTimeHelper._countWeeks(difference);
    } else if (difference / 1000 < 31536000) {
      result = DateTimeHelper._countMonths(difference);
    } else {
      result = DateTimeHelper._countYears(difference);
    }

    final isArabic = sl<LocalizationService>().isAr;

    if (!result.startsWith(tr('timeAgo.just_now'))) {
      return isArabic ? '${tr('timeAgo.ago')} $result' : '$result ${tr('timeAgo.ago')}';
    } else {
      return result;
    }
  }
}

/// [DateTimeHelper] contains static methods to calculate time units (seconds, minutes, hours, etc.)
/// from a given time difference in milliseconds and return the appropriate localized string.
///
/// This helper ensures that the main logic for converting time differences is modular and reusable.
class DateTimeHelper {
  DateTimeHelper._(); // Private constructor to prevent instantiation

  /// Returns the time difference in seconds, formatted as a localized string.
  /// - If the difference is more than 1 second, it returns "X seconds".
  /// - If less, it returns "just now".
  static String _countSeconds(int difference) {
    int count = (difference / 1000).truncate();
    return count > 1 ? tr('timeAgo.seconds', namedArgs: {'count': '$count'}) : tr('timeAgo.just_now');
  }

  /// Returns the time difference in minutes, formatted as a localized string.
  /// - If more than 1 minute, it returns "X minutes".
  /// - Otherwise, it returns "1 minute".
  static String _countMinutes(int difference) {
    int count = (difference / 60000).truncate();
    return count > 1 ? tr('timeAgo.minutes', namedArgs: {'count': '$count'}) : tr('timeAgo.minute');
  }

  /// Returns the time difference in hours, formatted as a localized string.
  /// - If more than 1 hour, it returns "X hours".
  /// - Otherwise, it returns "1 hour".
  static String _countHours(int difference) {
    int count = (difference / 3600000).truncate();
    return count > 1 ? tr('timeAgo.hours', namedArgs: {'count': '$count'}) : tr('timeAgo.hour');
  }

  /// Returns the time difference in days, formatted as a localized string.
  /// - If more than 1 day, it returns "X days".
  /// - Otherwise, it returns "1 day".
  static String _countDays(int difference) {
    int count = (difference / 86400000).truncate();
    return count > 1 ? tr('timeAgo.days', namedArgs: {'count': '$count'}) : tr('timeAgo.day');
  }

  /// Returns the time difference in weeks, formatted as a localized string.
  /// - If more than 1 week, it returns "X weeks".
  /// - Otherwise, it returns "1 week".
  static String _countWeeks(int difference) {
    int count = (difference / 604800000).truncate();
    return count > 1 ? tr('timeAgo.weeks', namedArgs: {'count': '$count'}) : tr('timeAgo.week');
  }

  /// Returns the time difference in months, formatted as a localized string.
  /// - If more than 1 month, it returns "X months".
  /// - Otherwise, it returns "1 month".
  static String _countMonths(int difference) {
    int count = (difference / 2628003000).round();
    return count > 1 ? tr('timeAgo.months', namedArgs: {'count': '$count'}) : tr('timeAgo.month');
  }

  /// Returns the time difference in years, formatted as a localized string.
  /// - If more than 1 year, it returns "X years".
  /// - Otherwise, it returns "1 year".
  static String _countYears(int difference) {
    int count = (difference / 31536000000).truncate();
    return count > 1 ? tr('timeAgo.years', namedArgs: {'count': '$count'}) : tr('timeAgo.year');
  }
}
