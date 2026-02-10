class ParseUtils {
  ParseUtils._();

  /// Safely parses dynamic value to int.
  static int ensureInt(dynamic value, {int defaultValue = 0}) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? defaultValue;
    if (value is double) return value.toInt();
    return defaultValue;
  }

  /// Safely parses dynamic value to double.
  static double ensureDouble(dynamic value, {double defaultValue = 0.0}) {
    if (value is double) return value;
    if (value is String) return double.tryParse(value) ?? defaultValue;
    if (value is int) return value.toDouble();
    return defaultValue;
  }

  /// Safely parses dynamic value to bool.
  static bool ensureBool(dynamic value, {bool defaultValue = false}) {
    if (value is bool) return value;
    if (value is int) return value != 0;
    if (value is String) {
      return value.toLowerCase() == 'true' || value == '1';
    }
    return defaultValue;
  }

  static DateTime ensureDateTime(dynamic value, {DateTime? defaultValue}) {
    if (value is DateTime) return value;
    if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (e) {
        //
      }
    }
    return defaultValue ?? DateTime.now();
  }

  /// Safely parses dynamic value to List.
  static List ensureList(dynamic value, {List defaultValue = const <dynamic>[]}) {
    if (value is List) return value;
    if (value is Iterable) return List.from(value);

    // Handle object with numeric keys (like {"0": {...}, "1": {...}})
    if (value is Map) {
      // Check if this looks like an object masquerading as a list
      // by having sequential numeric string keys starting from 0
      final keys = value.keys.whereType<String>().toList();

      // Try to parse all keys as integers and check if they form a sequence
      final numericKeys = keys.map((k) => int.tryParse(k)).where((k) => k != null).cast<int>().toList();

      if (numericKeys.isNotEmpty) {
        // Sort the numeric keys and check if they form a complete sequence from 0
        numericKeys.sort();
        final isSequential = numericKeys.asMap().entries.every((entry) => entry.key == entry.value);

        if (isSequential) {
          // Convert to list by ordering by numeric key
          return numericKeys.map((k) => value[k.toString()]).toList();
        } else {
          // If not sequential but has numeric keys, still try to convert to list
          // by sorting keys numerically and extracting values
          numericKeys.sort();
          return numericKeys.map((k) => value[k.toString()]).toList();
        }
      }

      // If no numeric string keys but has integer keys, handle those too
      final intKeys = value.keys.whereType<int>().toList();
      if (intKeys.isNotEmpty) {
        intKeys.sort();
        return intKeys.map((k) => value[k]).toList();
      }
    }

    return defaultValue;
  }
}
