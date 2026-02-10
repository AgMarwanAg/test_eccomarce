import 'dart:async';

import '../../core/logging/logger.dart';
import '../../shared/dio_client/result.dart';
import '../../shared/dio_client/api_exception.dart';

//----------- 1. UTILITY: Reusable Execute with Retry Function -----------
// This function can be placed in a common utility or helper file.

/// Executes an asynchronous [action] and retries it on failure.
///
/// **Note: Retry only occurs for 503 (Service Unavailable) errors.**
///
/// [T]: The type of data expected on success.
/// [action]: The asynchronous function to execute. It must return a `Future<Result<T>>`.
/// [onSuccess]: The callback to execute when the action succeeds.
/// [onFailure]: The callback to execute when the action fails after all retries.
/// [maxRetries]: The maximum number of times to retry the action. Defaults to 3.
/// [delayStrategy]: A function that returns the duration to wait before the next retry.
///          It receives the current attempt number (e.g., 1, 2, ...).
///          Defaults to an exponential backoff of `2 * attempt` seconds.
Future<void> executeWithRetry<T>({
  required Future<Result<T>> Function() action,
  required void Function(T data) onSuccess,
  required void Function(dynamic error) onFailure,
  int maxRetries = 3,
  Duration Function(int attempt)? delayStrategy,
}) async {
  int attempt = 1;
  while (attempt <= maxRetries) {
    try {
      final result = await action();
      bool isSuccess = false;
      bool shouldRetry = false;

      result.fold(
        onSuccess: (data) {
          onSuccess(data);
          isSuccess = true;
        },
        onFailure: (error) {
          // Only retry if the error is a 503 status code
          shouldRetry = _shouldRetryError(error);

          if (shouldRetry) {
            Logger.error('Attempt $attempt failed with 503 error. Retrying... Error: $error');
          } else {
            Logger.error('Attempt $attempt failed with non-503 error. Not retrying. Error: $error');
          }

          if (attempt == maxRetries || !shouldRetry) {
            onFailure(error);
          }
        },
      );

      // If the action was successful, exit the function.
      if (isSuccess) {
        return;
      }

      // If we shouldn't retry, exit immediately
      if (!shouldRetry) {
        return;
      }
    } catch (e) {
      // Catch exceptions from the action itself (not just Result.failure)
      bool shouldRetry = _shouldRetryError(e);

      if (shouldRetry) {
        Logger.error('Attempt $attempt threw a 503 exception. Retrying... Error: $e');
      } else {
        Logger.error('Attempt $attempt threw a non-503 exception. Not retrying. Error: $e');
      }

      if (attempt == maxRetries || !shouldRetry) {
        onFailure(e);
        return; // Exit after final failure or non-retryable error
      }
    }

    // Wait before the next attempt.
    if (attempt < maxRetries) {
      final delayDuration = delayStrategy?.call(attempt) ?? Duration(seconds: 2 * attempt);
      await Future.delayed(delayDuration);
    }

    attempt++;
  }
}

/// Helper function to determine if an error should trigger a retry.
/// 503 service unavailable.
bool _shouldRetryError(dynamic error) {
  if (error is ApiException) {
    List<int> retryStatusCodes = [503];

    return retryStatusCodes.contains(error.statusCode);
  }
  return false;
}
