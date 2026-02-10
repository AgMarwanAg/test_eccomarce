import 'package:dio/dio.dart';

class CustomInterceptor extends Interceptor {
  @override
   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // options.headers['city-id'] = '1';
    // options.headers['X-Branch-Id'] = '1';
    handler.next(options);
  }
}