import 'package:shared_preferences/shared_preferences.dart';

/// A service class for managing key-value storage using `SharedPreferences`.
class SharedPreferencesService {
  final SharedPreferences _preferences;

  /// Creates an instance of `SharedPreferencesService` with a provided `SharedPreferences` instance.
  SharedPreferencesService(this._preferences);

  /// Saves a string value associated with the given [key].
  ///
  /// Returns `true` if the operation is successful.
  Future<bool> saveString(String key, String value) async {
    return _preferences.setString(key, value);
  }

  /// Retrieves a string value associated with the given [key].
  ///
  /// Returns `null` if the key does not exist.
  String? getString(String key) {
    return _preferences.getString(key);
  }

  /// Saves an integer value associated with the given [key].
  ///
  /// Returns `true` if the operation is successful.
  Future<bool> saveInt(String key, int value) async {
    return _preferences.setInt(key, value);
  }

  /// Retrieves an integer value associated with the given [key].
  ////home/marwanag/Documents/DO/talqah_refactor/build/app/outputs/apk/dev/release/app-dev-arm64-v8a-release.apk
  /// Returns `null` if the key does not exist.
  int? getInt(String key) {
    return _preferences.getInt(key);
  }

  /// Saves a boolean value associated with the given [key].
  ///
  /// Returns `true` if the operation is successful.
  Future<bool> saveBool(String key, bool value) async {
    return _preferences.setBool(key, value);
  }

  /// Retrieves a boolean value associated with the given [key].
  ///
  /// Returns `null` if the key does not exist.
  bool? getBool(String key) {
    return _preferences.getBool(key);
  }

  /// Saves a double value associated with the given [key].
  ///
  /// Returns `true` if the operation is successful.
  Future<bool> saveDouble(String key, double value) async {
    return _preferences.setDouble(key, value);
  }

  /// Retrieves a double value associated with the given [key].
  ///
  /// Returns `null` if the key does not exist.
  double? getDouble(String key) {
    return _preferences.getDouble(key);
  }

  /// Saves a list of strings associated with the given [key].
  ///
  /// Returns `true` if the operation is successful.
  Future<bool> saveStringList(String key, List<String> value) async {
    return _preferences.setStringList(key, value);
  }

  /// Retrieves a list of strings associated with the given [key].
  ///
  /// Returns `null` if the key does not exist.
  List<String>? getStringList(String key) {
    return _preferences.getStringList(key);
  }

  /// Removes the value associated with the given [key].
  ///
  /// Returns `true` if the operation is successful.
  Future<bool> delete(String key) async {
    return _preferences.remove(key);
  }

  /// Clears all data stored in `SharedPreferences`.
  ///
  /// Returns `true` if the operation is successful.
  Future<bool> clearAll() async {
    return _preferences.clear();
  }
}
