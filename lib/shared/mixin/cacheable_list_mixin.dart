import 'dart:convert';
import '../../core/caching/shared_pref_services.dart';
import '../../core/di/locator.dart';

/// A mixin to provide caching functionality for lists of models.
/// 
/// Classes using this mixin must implement:
/// - [toMap]: Convert the object to a Map for JSON serialization
/// - [fromCacheJson]: Create an instance from cached JSON data
/// 
/// Example usage:
/// ```dart
/// class PaymentModel with CacheableListMixin<PaymentModel> {
///   ...
/// }
/// ```
mixin CacheableListMixin<T> {
  /// Convert a single object to a Map.
  Map<String, dynamic> toMap();

  /// Create an instance from cached JSON data.
  T fromCacheJson(Map<String, dynamic> json);

  /// Save a list of models to cache under the given key.
  static Future<bool> saveList<T>(
    String key,
    List<T> items,
    Map<String, dynamic> Function(T) toMap,
  ) async {
    try {
      final jsonList = items.map((e) => toMap(e)).toList();
      final jsonString = json.encode(jsonList);
      return await sl<SharedPreferencesService>().saveString(key, jsonString);
    } catch (e) {
      return false;
    }
  }

  /// Retrieve a cached list of models from the given key.
  static List<T>? getList<T>(
    String key,
    T Function(Map<String, dynamic>) fromCacheFactory,
  ) {
    try {
      final jsonString = sl<SharedPreferencesService>().getString(key);
      if (jsonString != null) {
        final decoded = json.decode(jsonString) as List<dynamic>;
        return decoded
            .map((e) => fromCacheFactory(e as Map<String, dynamic>))
            .toList();
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Clear a cached list from SharedPreferences.
  static Future<bool> clearList(String key) async {
    try {
      return await sl<SharedPreferencesService>().delete(key);
    } catch (e) {
      return false;
    }
  }
}
