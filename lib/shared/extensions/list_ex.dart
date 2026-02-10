extension ListExtension on List {
  List<dynamic> toggle(String i) {
    contains(i) ? remove(i) : add(i);
    return this;
  }

  void toggleInt(int i) {
    contains(i) ? remove(i) : add(i);
  }

  void swap(int index1, int index2) {
    if (index1 < 0 || index1 >= length || index2 < 0 || index2 >= length) {
      throw RangeError('Invalid indices provided for swapping');
    }
    var temp = this[index1];
    this[index1] = this[index2];
    this[index2] = temp;
  }
}

extension DateTimeListExtension on List<DateTime> {
  List<String> toYMD() {
    return map((dateTime) => "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}").toList();
  }
}

extension SafeListAccess<T> on List<T>? {
  T? safeGet(int index) {
    if (this != null && index >= 0 && index < this!.length) {
      return this![index];
    }
    return null;  
  }
}