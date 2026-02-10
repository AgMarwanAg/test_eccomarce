import 'package:flutter/material.dart';

/// Extension on [Widget] to provide convenience methods for adding padding using [Padding] widget.
extension PaddingEx on Widget {
  /// Adds padding to all sides of the widget.
  ///
  /// Example usage:
  /// ```dart
  /// Text('Hello').paddingAll(16.0)
  /// ```
  Widget paddingAll(double padding) =>
      Padding(padding: EdgeInsetsDirectional.all(padding), child: this);

  /// Adds vertical padding (top and bottom) to the widget.
  ///
  /// Example usage:
  /// ```dart
  /// Text('Hello').paddingVertical(16.0)
  /// ```
  Widget paddingVertical(double padding) => Padding(
    padding: EdgeInsetsDirectional.symmetric(vertical: padding),
    child: this,
  );

  /// Adds horizontal padding (left and right) to the widget.
  ///
  /// Example usage:
  /// ```dart
  /// Text('Hello').paddingHorizontal(16.0)
  /// ```
  Widget paddingHorizontal(double padding) => Padding(
    padding: EdgeInsetsDirectional.symmetric(horizontal: padding),
    child: this,
  );

  /// Adds symmetric padding (horizontal and vertical) to the widget.
  ///
  /// Example usage:
  /// ```dart
  /// Text('Hello').paddingSymmetric(h: 16.0, v: 8.0)
  /// ```
  Widget paddingSymmetric({double h = 0, double v = 0}) => Padding(
    padding: EdgeInsetsDirectional.symmetric(horizontal: h, vertical: v),
    child: this,
  );

  /// Adds padding with specific values for each side.
  ///
  /// Example usage:
  /// ```dart
  /// Text('Hello').paddingOnly(top: 8.0, start: 16.0)
  /// ```
  Widget paddingOnly({
    double top = 0.0,
    double start = 0.0,
    double bottom = 0.0,
    double end = 0.0,
  }) => Padding(
    padding: EdgeInsetsDirectional.only(
      top: top,
      start: start,
      bottom: bottom,
      end: end,
    ),
    child: this,
  );

  /// Adds padding to the top of the widget.
  ///
  /// Example usage:
  /// ```dart
  /// Text('Hello').paddingTop(16.0)
  /// ```
  Widget paddingTop(double top) =>
      Padding(padding: EdgeInsetsDirectional.only(top: top), child: this);

  /// Adds padding to the bottom of the widget.
  ///
  /// Example usage:
  /// ```dart
  /// Text('Hello').paddingBottom(16.0)
  /// ```
  Widget paddingBottom(double bottom) =>
      Padding(padding: EdgeInsetsDirectional.only(bottom: bottom), child: this);

  /// Adds padding to the start (left in LTR, right in RTL) of the widget.
  ///
  /// Example usage:
  /// ```dart
  /// Text('Hello').paddingStart(16.0)
  /// ```
  Widget paddingStart(double start) =>
      Padding(padding: EdgeInsetsDirectional.only(start: start), child: this);

  /// Adds padding to the end (right in LTR, left in RTL) of the widget.
  ///
  /// Example usage:
  /// ```dart
  /// Text('Hello').paddingEnd(16.0)
  /// ```
  Widget paddingEnd(double end) =>
      Padding(padding: EdgeInsetsDirectional.only(end: end), child: this);

  /// Adds padding to the widget using the specified [EdgeInsetsGeometry].
  ///
  /// Example usage:
  /// ```dart
  /// Text('Hello').padding(EdgeInsets.all(16.0))
  /// ```
  Widget padding(EdgeInsetsGeometry padding) =>
      Padding(padding: padding, child: this);
}
