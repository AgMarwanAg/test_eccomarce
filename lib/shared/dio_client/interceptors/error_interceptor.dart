import 'package:dio/dio.dart';

import '../../../core/di/locator.dart';
import '../../cubits/session_cubit/session_cubit.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      sl<SessionCubit>().logout();
    }
    handler.next(err);
  }
}