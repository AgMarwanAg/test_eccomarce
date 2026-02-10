import 'package:dio/dio.dart';

/// An interceptor class that handles authentication for API requests.
///
/// This class is responsible for attaching an authorization token to the request headers
/// if the user is logged in. This token is used to authenticate the user for protected
/// API endpoints.
///
/// The token is retrieved from the user's cached data and added to the request headers
/// before the request is sent. If the user is not logged in, the token is not added.
///
/// The `onRequest` method is overridden to add the authorization token to the request headers.
class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // final token = UserModel.cache()?.token;
    // if (token != null) {
    //   options.headers['Authorization'] = 'Bearer $token';
    // }
    handler.next(options);
  }
}
