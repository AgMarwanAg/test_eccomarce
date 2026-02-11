import 'package:test_eccomarce/core/database/database_helper.dart';
import 'package:test_eccomarce/features/home/features/home_tab/data/model/home_model.dart';

abstract class HomeLocalDataSource {
  Future<void> cacheHome(HomeModel homeModel);
  Future<HomeModel?> getCachedHome();
  // Future<void> clearCache();
  // Future<bool> hasCachedData();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  final DatabaseHelper _databaseHelper;

  HomeLocalDataSourceImpl(this._databaseHelper);

  static const String _homeKey = 'home_data';

  @override
  Future<void> cacheHome(HomeModel homeModel) async {
    final box = await _databaseHelper.getHomeCacheBox();
    await box.put(_homeKey, homeModel);
  }

  @override
  Future<HomeModel?> getCachedHome() async {
    final box = await _databaseHelper.getHomeCacheBox();
    return box.get(_homeKey) as HomeModel?;
  }

  // @override
  // Future<void> clearCache() async {
  //   await _databaseHelper.clearBox(HiveBoxNames.homeCache);
  // }

  // @override
  // Future<bool> hasCachedData() async {
  //   final box = await _databaseHelper.getHomeCacheBox();
  //   return box.containsKey(_homeKey);
  // }
}
