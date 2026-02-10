import 'package:async/async.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
/// A mixin that adds cancellation functionality to a [Cubit].
///
/// This mixin provides a way to cancel long-running operations
/// in a [Cubit]. It uses a [CancelableOperation] to manage the
/// cancellation of the operation.
///
/// To use this mixin, you must extend [Cubit] with
/// [CancelableCubitMixin]. You can then use the [runCancellable]
/// method to run a long-running operation that can be cancelled.
///
/// The [close] method is overridden to cancel any running
/// operation when the [Cubit] is closed.
///
/// Example:
///
/// 
mixin CancelableCubitMixin<S> on Cubit<S> {
  CancelableOperation? _operation;
  Future<T?> runCancellable<T>(
    Future<T> future, {
    void Function()? onCancel,
  }) async {
    await _operation?.cancel();
    _operation = CancelableOperation.fromFuture(
      future,
      onCancel: onCancel,
    );

    return await _operation!.valueOrCancellation();
  }

  @override
  Future<void> close() async {
    await _operation?.cancel();
     return super.close();
  }
}
