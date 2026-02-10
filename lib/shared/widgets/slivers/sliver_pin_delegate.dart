import 'package:flutter/material.dart';

class SliverPinnedDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double minExtentValue, maxExtentValue;
  final bool rebuild;

  SliverPinnedDelegate({
    required this.child,
    required this.minExtentValue,
    required this.maxExtentValue,
    this.rebuild = false,
  });

  @override
  double get minExtent => minExtentValue;

  @override
  double get maxExtent => maxExtentValue;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      color: Colors.transparent,
      child: child,
    );
  }

  @override
  bool shouldRebuild(covariant SliverPinnedDelegate oldDelegate) {
    return rebuild;
  }
}
