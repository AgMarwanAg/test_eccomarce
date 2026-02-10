import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

/// Enum representing various error messages for different types of failures.
///
/// Each error message corresponds to a common error type that may occur during
/// HTTP requests, such as timeouts or connection issues.
enum ErrorMessage {
  // CORRECTED: Added 'exc.' prefix for consistency with JSON structure.
  connectionTimeout('exc.connectionTimeout'),
  sendTimeout('exc.sendTimeout'),
  receiveTimeout('exc.receiveTimeout'),
  requestCanceled('exc.requestCanceled'),
  noInternet('exc.noInternet'),
  unknown('exc.unknown'),
  unexpected('exc.unexpected');

  /// Human-readable error message corresponding to the error.
  final String message;

  /// Constructor for [ErrorMessage] enum that assigns a specific error message.
  const ErrorMessage(this.message);
}

/// A custom exception class used for handling API-related errors.
class ApiException implements Exception {
  /// The error message explaining the nature of the error.
  final String? message;

  /// The HTTP status code received from the server, if applicable.
  final int? statusCode;

  /// Constructor for [ApiException] that allows setting an optional error [message]
  /// and [statusCode].
  ApiException({this.message = 'error', this.statusCode});

  /// Factory method that handles the conversion of dynamic errors into [ApiException] instances.
  static ApiException handleError(dynamic error) {
    if (error is DioException) {
      return _handleDioException(error);
    } else if (error is SocketException) {
      return ApiException(
        statusCode: 503, // Service Unavailable
        // CORRECTED: Use tr() to get the localized message.
        message: tr(ErrorMessage.noInternet.message),
      );
    } else {
      // Catch all other errors as unknown
      return ApiException(message: tr(ErrorMessage.unknown.message));
    }
  }

  /// Private method to handle Dio-specific exceptions.
  static ApiException _handleDioException(DioException error) {
    final statusCode = error.response?.statusCode;

    // CORRECTED: Use tr() to get the localized messages from the enum.
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiException(
          message: tr(ErrorMessage.connectionTimeout.message),
          statusCode: 503,
        );
      case DioExceptionType.sendTimeout:
        return ApiException(
          message: tr(ErrorMessage.sendTimeout.message),
          statusCode: statusCode,
        );
      case DioExceptionType.receiveTimeout:
        return ApiException(
          message: tr(ErrorMessage.receiveTimeout.message),
          statusCode: statusCode,
        );
      case DioExceptionType.badResponse:
        return ApiException(
          message: _handleStatusCode(statusCode, error: error),
          statusCode: statusCode,
        );
      case DioExceptionType.cancel:
        return ApiException(
          message: tr(ErrorMessage.requestCanceled.message),
          statusCode: statusCode,
        );
      case DioExceptionType.connectionError:
        return ApiException(
          message: tr(ErrorMessage.noInternet.message),
          statusCode: 503,
        );
      case DioExceptionType.unknown:
      default:
        return ApiException(
          message: tr(ErrorMessage.unexpected.message),
          statusCode: statusCode,
        );
    }
  }

  /// A helper method to convert HTTP status codes into user-friendly messages.
  static String _handleStatusCode(int? statusCode, {DioException? error}) {
    // CORRECTED: Added 'exc.' prefix to all keys.
    final statusMessages = {
      400: _getBadResponseMessage(error?.response),
      401: tr('exc.unauthorized'),
      403: tr('exc.forbidden'),
      404: tr('exc.notFound'),
      422: _getAllErrorMessages(error?.response),
      500: _getServerError(error?.response),
      503: tr('exc.service_unavailable_now'),
    };

    // CORRECTED: Updated the fallback message key.
    return statusMessages[statusCode] ?? tr('exc.invalid_status_code', namedArgs: {'code': '$statusCode'});
  }

  /// Gets the server error message or a localized fallback for 500 errors.
  static String _getServerError(Response<dynamic>? response) {
    // Prefer the specific message from the server response if it exists.
    if (response?.data != null && response?.data['message'] is String) {
      return response!.data['message'].toString();
    }
    // Otherwise, use the localized fallback for internal server error.
    return tr('exc.internalServerError');
  }

  /// Parses validation errors (422) from the response body.
  static String _getAllErrorMessages(Response<dynamic>? response) {
    if (response?.data == null) {
      // CORRECTED: Use localized key for parsing error.
      return tr('exc.error_parsing_error_response');
    }
    try {
      final responseData = response!.data;
      final errors = responseData['errors'];
      final message = responseData['message'];

      if (errors is Map<String, dynamic>) {
        final errorMessages = errors.values.expand((fieldErrors) => fieldErrors is List ? fieldErrors.map((e) => '$e') : ['$fieldErrors']).join('\n');

        return "$message\n$errorMessages";
      }

      if (message is String) {
        return message;
      }

      return tr('exc.unknown');
    } catch (_) {
      return tr('exc.error_parsing_error_response');
    }
  }

  static String _getBadResponseMessage(Response? response) {
    if (response?.data != null && response?.data['message'] is String) {
      return response!.data['message'].toString();
    }
    return tr('exc.badRequest');
  }

  @override
  String toString() => 'Error: $message${statusCode != null ? ' (Status code: $statusCode)' : ''}';
}
