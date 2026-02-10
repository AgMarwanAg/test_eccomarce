// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:medical_house/config/style/app_colors.dart';
// import 'package:shimmer/shimmer.dart';

// class TextShimmer extends StatefulWidget {
//   const TextShimmer.light({super.key, this.height = 20, this.width});
//   const TextShimmer.medium({super.key, this.height = 30, this.width});
//   const TextShimmer.bold({super.key, this.height = 40, this.width});
//   const TextShimmer({this.width, super.key, this.height});
//   final double? height;
//   final double? width;
//   @override
//   State<TextShimmer> createState() => _TextShimmerState();
// }

// class _TextShimmerState extends State<TextShimmer> {
//   @override
//   Widget build(BuildContext context) {
//     return Shimmer.fromColors(
//       highlightColor: AppColors.highlightColor,
//       baseColor: AppColors.baseColor,
//       child: Container(
//         height: widget.height?.h,
//         width: widget.width?.w ?? double.infinity,
//         color: AppColors.baseColor,
//       ),
//     );
//   }
// }
