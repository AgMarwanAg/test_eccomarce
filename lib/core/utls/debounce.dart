import 'dart:async';

/// A class that can be used to debounce a function, i.e. to ensure that it is
/// not called more frequently than a certain amount.
///
/// This class is used to prevent a function from being called too frequently,
/// for example when a text field is being edited. It can also be used to group
/// multiple calls to a function together, so that they are executed less
/// frequently.
///
/// The class works by keeping a single timer, and whenever the `call` method is
/// called, it cancels the previous timer and starts a new one. When the timer
/// finally expires, the provided callback is called.
///
/// The timer is cancelled when the `dispose` method is called, so that the class
/// can be used as a mixin without causing any memory leaks.
class Debounce {
  final Duration? delay;
  Timer? _timer;

  Debounce({this.delay});

  void call(void Function() callback) {
    _timer?.cancel(); // Cancel previous timer if it exists
    _timer = Timer(
      delay ?? Duration(seconds: 1),
      callback,
    ); // Start a new timer
  }

  void dispose() {
    _timer?.cancel();
  }
}
