extension IterableExtension<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }

  T? getByIndex(int index) {
    if (length > index) {
      return elementAt(index);
    }
    return null;
  }
  T? get(int index) {
    if(length>index) {
      return elementAt(index);
    }
    return null;
  }
  
}

extension NullableIterableExtensions<E> on Iterable<E>? {
  // Common - Equality

  /// Returns `true` if iterable is `null` or empty.
  bool get isNullOrEmpty {
    return this?.isEmpty ?? true;
  }

  /// Returns `true` if iterable is not `null` and not empty.
  bool get isNotNullOrEmpty {
    return this?.isNotEmpty ?? false;
  }
}