import 'package:dio/dio.dart';
import '../../config/flavors/flavor_config.dart';
import '../../core/logging/logger.dart';
import 'api_exception.dart';
import 'interceptors/interceptors_export.dart';
import 'result.dart';

/// A client class that wraps the Dio package for making HTTP requests.
/// This class provides `GET` and `POST` methods to interact with a RESTful API.
/// It handles API responses and errors gracefully, returning a `Result` object
/// that indicates success or failure.
///
/// The DioClient class can be used for fetching data from an API using the `GET` method
/// or sending data with the `POST` method. Additionally, it handles request and response
/// logging using interceptors.
class DioClient{
  late Dio _dio;

  DioClient() {
    BaseOptions options = BaseOptions(
      baseUrl: "${FlavorConfig.instance.baseUrl}/api",
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        // 'Authorization': 'Bearer ${UserModel.cache()?.token}',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    _dio = Dio(options);
    _dio.interceptors.addAll([
      LoggingInterceptor(),
      AuthInterceptor(),
      LocalizationInterceptor(),
      AppInfoInterceptor(),
      ErrorInterceptor(),
      // CustomInterceptor(),
    ]);
  }

  /// Performs a GET request to the given [endpoint].
  ///
  /// - [useCache]: Whether to enable cache (default: true).
  /// - [forceRefresh]: If true, forces fresh request bypassing cache.
  /// - [cacheDuration]: Custom cache TTL (default: 1 hour).
  Future<Result> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Options? option,
  }) async {
    try {
      // Build cache options if useCache is true
     

      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
      );
      return Result.success(response.data);
    } catch (e) {
      return Result.failure(ApiException.handleError(e));
    }
  }

  /// Mock function to simulate a network request
  /// - [fakeData]: The fake data to return
  /// Duration: The duration to simulate network latency
  /// Returns a [Result] object which either contains the response data
  /// on success, or an error message on failure
  Future<Result> mockGet(
    Object fakeData, {
    Duration duration = const Duration(seconds: 3),
    bool isError = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    await Future.delayed(duration);
    if (isError) return Result.failure(ApiException(message: 'Error'));
    return Result.success(fakeData);
  }

  /// Performs a `POST` request to the given [endpoint].
  ///
  /// - [endpoint]: The API endpoint to send the request to.
  /// - [data]: Optional data to be included in the request body.
  /// - [queryParameters]: Optional query parameters to include in the request.
  ///
  /// Returns a [Result] object which either contains the response data
  /// on success, or an error message on failure.
  ///
  /// Example:
  /// ```dart
  /// var result = await dioClient.post('/login', data: {'username': 'user', 'password': 'pass'});
  /// ```
  Future<Result> post(
    String endpoint, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      Response response = await _dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return Result.success(response.data); // Return success with data
    } catch (e) {
      Logger.error(e.toString());
      return Result.failure(
        ApiException.handleError(e),
        // ApiException(message: e.toString()),
      ); // Return failure with error
    }
  }

  /// performs a `PATCH` request to the given [endpoint].
  ///
  /// - [endpoint]: The API endpoint to send the request to.
  /// - [data]: Optional data to be included in the request body.
  /// - [queryParameters]: Optional query parameters to include in the request.
  ///
  /// Returns a [Result] object which either contains the response data
  /// on success, or an error message on failure.
  ///
  /// Example:
  /// ```dart
  /// var result = await dioClient.patch('/update', data: {'username': 'user', 'password': 'pass'});
  /// ```
  Future<Result> patch(
    String endpoint, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Response response = await _dio.patch(
        endpoint,
        data: data,
        queryParameters: queryParameters,
      );
      return Result.success(response.data); // Return success with data
    } catch (e) {
      return Result.failure(
        ApiException.handleError(e),
      ); // Return failure with error
    }
  }

  /// performs a `put` request to the given [endpoint].
  ///
  /// - [endpoint]: The API endpoint to send the request to.
  /// - [data]: Optional data to be included in the request body.
  /// - [queryParameters]: Optional query parameters to include in the request.
  ///
  /// Returns a [Result] object which either contains the response data
  /// on success, or an error message on failure.
  ///
  /// Example:
  /// ```dart
  /// var result = await dioClient.patch('/update', data: {'username': 'user', 'password': 'pass'});
  /// ```
  Future<Result> put(
    String endpoint, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Response response = await _dio.put(
        endpoint,
        data: data,
        queryParameters: queryParameters,
      );
      return Result.success(response.data); // Return success with data
    } catch (e) {
      return Result.failure(
        ApiException.handleError(e),
      ); // Return failure with error
    }
  }

  /// performs a `DELETE` request to the given [endpoint].
  ///
  /// - [endpoint]: The API endpoint to send the request to.
  /// - [data]: Optional data to be included in the request body.
  /// - [queryParameters]: Optional query parameters to include in the request.
  ///
  /// Returns a [Result] object which either contains the response data
  /// on success, or an error message on failure.
  ///
  /// Example:
  /// ```dart
  /// var result = await dioClient.delete('/delete', data: {'username': 'user', 'password': 'pass'});
  /// ```
  Future<Result> delete(
    String endpoint, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Response response = await _dio.delete(
        endpoint,
        data: data,
        queryParameters: queryParameters,
      );
      return Result.success(response.data); // Return success with data
    } catch (e) {
      return Result.failure(
        ApiException.handleError(e),
      ); // Return failure with error
    }
  }

  /// performs a `download` request to the given [endpoint].
  Future<Result> download(
    String endpoint,
    dynamic savePath, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Response response = await _dio.download(
        endpoint,
        savePath,
        data: data,
        queryParameters: queryParameters,
      );
      return Result.success(response.data); // Return success with data
    } catch (e) {
      return Result.failure(
        ApiException.handleError(e),
      ); // Return failure with error
    }
  }
}
