import 'package:dio/dio.dart';

/// Adds application-specific headers to the request.
///
/// The headers include the application display name, version, build number,
/// platform identifier, package/bundle identifier, and user agent string.
///
/// The user agent string is formatted as follows:
/// "Incognito/${_appInfo.appName}/${_appInfo.appVersion} (android; ${_appInfo.platform}; Build/${_appInfo.buildNumber}; Package/${_appInfo.packageName})"
///
/// The [RequestOptions] object is modified in-place to add the headers.
class AppInfoInterceptor extends Interceptor {
  // final AppInfo _appInfo = sl<AppInfo>();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // options.headers.addAll({
    //   ///Application display name
    //   'X-App-Name': _appInfo.appName,
    //   /// Application version (e.g., "1.0.0")
    //   'X-App-Version': _appInfo.appVersion,
    //   ///Application build number
    //   'X-Build-Number': _appInfo.buildNumber,
    //   ///Platform identifier ("android" or "ios")
    //   'X-Platform': _appInfo.platform,
    //   ///Application package/bundle identifier
    //   'X-Package-Name': _appInfo.packageName,
    //   // ///Formatted user agent string
    //   // 'User-Agent': _appInfo.userAgent,
    // });
    super.onRequest(options, handler);
  }
}
