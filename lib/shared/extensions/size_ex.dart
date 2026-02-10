import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Extension on [num] to provide convenience methods for creating SizedBox widgets with specific heights or widths.
extension SizedBoxExtension on num {
  /// Creates a SizedBox widget with a specific height.
  ///
  /// Example usage:
  /// ```dart
  /// 100.sizeH
  /// ```
  Widget get sizeH => SizedBox(height: toDouble().h);

  /// Creates a SizedBox widget with a specific width.
  ///
  /// Example usage:
  /// ```dart
  /// 50.sizeW
  /// ```
  Widget get sizeW => SizedBox(width: toDouble().w);
}
