class ParseUtils {
  ParseUtils._();

  // ---------- Numbers ----------

  static int asInt(dynamic value, {int fallback = 0}) {
    return switch (value) {
      int v => v,
      double v => v.toInt(),
      String v => int.tryParse(v) ?? fallback,
      _ => fallback,
    };
  }

  static double asDouble(dynamic value, {double fallback = 0.0}) {
    return switch (value) {
      double v => v,
      int v => v.toDouble(),
      String v => double.tryParse(v) ?? fallback,
      _ => fallback,
    };
  }

  // ---------- Bool ----------

  static bool asBool(dynamic value, {bool fallback = false}) {
    return switch (value) {
      bool v => v,
      int v => v != 0,
      String v =>
        v == '1' || v.toLowerCase() == 'true',
      _ => fallback,
    };
  }

  // ---------- DateTime ----------

  static DateTime asDateTime(
    dynamic value, {
    DateTime? fallback,
  }) {
    if (value is DateTime) return value;
    if (value is String) {
      return DateTime.tryParse(value) ?? fallback ?? DateTime.now();
    }
    return fallback ?? DateTime.now();
  }

  // ---------- List ----------

  static List<T> asList<T>(
    dynamic value, {
    List<T> fallback = const [],
  }) {
    if (value is List) {
      return value.whereType<T>().toList();
    }

    if (value is Iterable) {
      return value.whereType<T>().toList();
    }

    if (value is Map) {
      final entries = value.entries.toList()
        ..sort((a, b) => a.key.toString().compareTo(b.key.toString()));

      return entries
          .map((e) => e.value)
          .whereType<T>()
          .toList();
    }

    return fallback;
  }
}
