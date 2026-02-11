import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_eccomarce/core/database/hive_box_names.dart';
import 'package:test_eccomarce/features/home/features/home_tab/data/model/home_model.dart';
import 'package:test_eccomarce/shared/models/category_model.dart';
import 'package:test_eccomarce/shared/models/product_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static DatabaseHelper get instance => _instance;
  DatabaseHelper._internal();

  bool _isInitialized = false;

  Future<void> init() async {
    if (_isInitialized) return;

    await Hive.initFlutter();

    Hive.registerAdapter(ProductModelAdapter());
    Hive.registerAdapter(CategoryModelAdapter());
    Hive.registerAdapter(HomeModelAdapter());

    _isInitialized = true;
  }

  Future<Box<T>> getBox<T>(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      return await Hive.openBox<T>(boxName);
    }
    return Hive.box<T>(boxName);
  }

  /// Get home cache box
  Future<Box> getHomeCacheBox() async {
    return await getBox(HiveBoxNames.homeCache);
  }

  Future<Box> getProductsBox() async {
    return await getBox(HiveBoxNames.products);
  }

  Future<Box> getCategoriesBox() async {
    return await getBox(HiveBoxNames.categories);
  }

  Future<void> clearBox(String boxName) async {
    final box = await getBox(boxName);
    await box.clear();
  }

  Future<void> clearAllCache() async {
    await clearBox(HiveBoxNames.homeCache);
    await clearBox(HiveBoxNames.products);
    await clearBox(HiveBoxNames.categories);
  }

  Future<void> closeBox(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      await Hive.box(boxName).close();
    }
  }

  Future<void> closeAllBoxes() async {
    await Hive.close();
  }

  Future<void> deleteBox(String boxName) async {
    await Hive.deleteBoxFromDisk(boxName);
  }

  bool get isInitialized => _isInitialized;
}
