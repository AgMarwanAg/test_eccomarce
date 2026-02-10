import 'package:dio/dio.dart';

import '../../../core/di/locator.dart';
import '../../../core/localization/localization_service.dart';

class LocalizationInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers['Accept-Language'] = sl<LocalizationService>().currentLocale.languageCode;
    handler.next(options);
  }
}
