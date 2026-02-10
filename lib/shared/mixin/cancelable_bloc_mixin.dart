import 'package:async/async.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
/// A mixin that provides cancellation functionality for operations
/// within a [Bloc].
///
/// This mixin provides a way to cancel ongoing operations
/// and to run new operations with cancellation support.
///
/// The [runCancellable] method is used to run an operation
/// with cancellation support. It takes a future and optional
/// parameters. The future is the operation to be run, and
/// the parameters are the operation key and the on cancel callback.
///
/// The [close] method is used to cancel all ongoing operations
/// when the [Bloc] is closed.
///
/// This mixin is intended to be used as a mixin for a [Bloc]
/// to provide cancellation support for operations within that [Bloc].
///
/// Example usage:
///
/// 
mixin CancelableBlocMixin<E, S> on Bloc<E, S> {
  final Map<String, CancelableOperation> _operations = {};

  Future<T?> runCancellable<T>(
    Future<T> future, {
    String operationKey = 'default',
    void Function()? onCancel,
  }) async {
    // Cancel any existing operation with the same key
    await _operations[operationKey]?.cancel();
    
    // Create and store the new operation
    _operations[operationKey] = CancelableOperation.fromFuture(
      future,
      onCancel: onCancel,
    );

    return await _operations[operationKey]!.valueOrCancellation();
  }

  @override
  Future<void> close() async {
    // Cancel all ongoing operations
    for (final operation in _operations.values) {
      await operation.cancel();
    }
    _operations.clear();
    return super.close();
  }
}