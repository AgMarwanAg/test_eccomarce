import 'package:dio/dio.dart';

import '../../../core/logging/logger.dart';

class LoggingInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    Logger.route(
      '[${options.method}] ${options.uri.toString()} '
      '${options.method != 'GET' ? options.data : ''}',
    );
    handler.next(options);
  }

  // You can also add response and error logging if needed
  // @override
  // void onResponse(Response response, ResponseInterceptorHandler handler) {
  //   Logger.route(
  //     '[${response.statusCode}] ${response.requestOptions.uri .toString()}',
  //   );
  //   handler.next(response);
  // }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    Logger.error(
      '${err.requestOptions.uri.toString()} - ${err.response?.statusCode}',
    );
    handler.next(err);
  }
}
