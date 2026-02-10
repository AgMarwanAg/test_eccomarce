import 'dart:convert';

import '../../core/caching/shared_pref_services.dart';
import '../../core/di/locator.dart';

/// A mixin that provides caching functionality for model classes.
/// 
/// Classes using this mixin must implement:
/// - [toMap]: Convert the object to a Map for JSON serialization
/// - [fromCacheJson]: Create an instance from cached JSON data
/// - [getCacheKey]: Provide a default cache key for the object
/// 
/// Example usage:
/// ```dart
/// class UserModel extends Equatable with CacheableMixin<UserModel> {
///   @override
///   Map<String, dynamic> toMap() => {'id': id, 'name': name};
///   
///   @override
///   UserModel fromCacheJson(Map<String, dynamic> json) => UserModel._fromCache(json);
///   
///   @override
///   String getCacheKey() => 'user';
/// }
/// ```
mixin CacheableMixin<T> {
  /// Convert the object to a Map for JSON serialization.
  /// This method must be implemented by classes using this mixin.
  Map<String, dynamic> toMap();

  /// Create an instance from cached JSON data.
  /// This method must be implemented by classes using this mixin.
  T fromCacheJson(Map<String, dynamic> json);

  /// Provide a default cache key for the object.
  /// This method must be implemented by classes using this mixin.
  String getCacheKey();

  /// Saves this object instance to SharedPreferences.
  /// 
  /// [key] - Optional custom cache key. If not provided, uses [getCacheKey()]
  /// 
  /// Returns `true` if the operation is successful.
  Future<bool> saveToCache([String? key]) async {
    try {
      final jsonString = json.encode(toMap());
      final cacheKey = key ?? getCacheKey();
      return await sl<SharedPreferencesService>().saveString(cacheKey, jsonString);
    } catch (e) {
      // Log error if needed
      return false;
    }
  }

  /// Clears the cached data for this object.
  /// 
  /// [key] - Optional custom cache key. If not provided, uses [getCacheKey()]
  /// 
  /// Returns `true` if the operation is successful.
  Future<bool> clearCache([String? key]) async {
    try {
      final cacheKey = key ?? getCacheKey();
      return await sl<SharedPreferencesService>().delete(cacheKey);
    } catch (e) {
      // Log error if needed
      return false;
    }
  }

  /// Retrieves a cached instance from SharedPreferences.
  /// 
  /// [key] - The cache key to retrieve data from
  /// [fromCacheFactory] - Factory function to create instance from cached JSON
  /// 
  /// Returns the cached instance or `null` if not found or invalid.
  /// 
  /// Example usage:
  /// ```dart
  /// UserModel? cachedUser = CacheableMixin.getCachedInstance<UserModel>(
  ///   'user',
  ///   (json) => UserModel._fromCache(json),
  /// );
  /// ```
  static T? getCachedInstance<T>(
    String key,
    T Function(Map<String, dynamic>) fromCacheFactory,
  ) {
    try {
      final jsonString = sl<SharedPreferencesService>().getString(key);
      if (jsonString != null) {
        final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
        return fromCacheFactory(jsonMap);
      }
      return null;
    } catch (e) {
      // Log error if needed
      return null;
    }
  }

  /// Checks if cached data exists for the given key.
  /// 
  /// [key] - The cache key to check
  /// 
  /// Returns `true` if cached data exists, `false` otherwise.
  static bool hasCachedData(String key) {
    try {
      final jsonString = sl<SharedPreferencesService>().getString(key);
      return jsonString != null && jsonString.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  /// Clears all cached data from SharedPreferences.
  /// 
  /// Returns `true` if the operation is successful.
  static Future<bool> clear(String key) async {
    try {
      return await sl<SharedPreferencesService>().delete(key);
    } catch (e) {
      return false;
    }
  }
}