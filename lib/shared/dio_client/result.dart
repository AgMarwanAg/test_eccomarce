import '../../core/logging/logger.dart';
import 'api_exception.dart';

/// A generic class to represent the result of an operation,
/// which can either be a success containing data or a failure containing an exception.
class Result<T> {
  /// The data returned in case of success.
  final T? data;

  /// The exception returned in case of failure.
  final ApiException? exception;

  /// Creates a [Result] instance.
  ///
  /// Either [data] or [exception] should be provided, but not both.
  Result({this.data, this.exception});

  /// Factory constructor to create a success [Result] with the provided [data].
  factory Result.success(T data) => Result(data: data);

  /// Factory constructor to create a failure [Result] with the provided [exception].
  ///
  /// Logs the [exception] using the [Logger].
  factory Result.failure(ApiException exception) {
    return Result(exception: exception);
  }

  /// Returns `true` if the result is a success, i.e., it contains [data].
  bool get isSuccess => data != null;

  /// Returns `true` if the result is a failure, i.e., it contains [exception].
  bool get isFailure => exception != null;

  /// Folds the [Result] into a single value by applying either [onSuccess] or [onFailure].
  ///
  /// - [onSuccess] is called with the [data] if the result is a success.
  /// - [onFailure] is called with the [exception] if the result is a failure.
  ///
  /// Returns the value returned by the corresponding function.
  R fold<R>({
    required R Function(T data) onSuccess,
    required R Function(ApiException exception) onFailure,
  }) {
    if (isSuccess) {
      return onSuccess(data as T);
    } else {
      return onFailure(exception!);
    }
  }

  @override
  String toString() {
    if (isSuccess) {
      return 'Success: $data';
    } else {
      return 'Failure: ${exception?.toString()}';
    }
  }

 static Future<Result<T>> handleApiResponse<T>(
    Future<Result<dynamic>> apiCall,
    T Function(dynamic data) parseData, {
    String? exceptionMessage,
  }) async {
    try {
      final result = await apiCall;

      return result.fold(
        onSuccess: (data) {
          try {
            final parsedData = parseData(data);
            return Result.success(parsedData);
          } catch (e) {
            Logger.error('Parsing exception: ${e.toString()}');
            return Result.failure(ApiException(message: exceptionMessage ?? e.toString()));
          }
        },
        onFailure: (exception) {
          Logger.error('API Failure: ${exception.toString()}');
          return Result.failure(exception);
        },
      );
    } catch (e) {
      Logger.error('Unhandled exception: ${e.toString()}');
      return Result.failure(ApiException(message: exceptionMessage ?? e.toString()));
    }
  }
}

/// Represents a success result containing [data].
///
/// This is a specialized subclass of [Result].
class Success<T> extends Result {
  /// Creates a [Success] instance with the given [data].
  Success(T data) : super(data: data);
}

/// Represents a failure result containing an [ApiException].
///
/// This is a specialized subclass of [Result].
class Failure<T> extends Result {
  /// Creates a [Failure] instance with the given [exception].
  Failure(ApiException exception) : super(exception: exception);
}
