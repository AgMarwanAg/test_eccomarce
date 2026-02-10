import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_eccomarce/shared/widgets/images/svg_image.dart';
import '../../../config/style/app_colors.dart';
import '../../extensions/string_ex.dart';

import '../shimmer/skeleton_widget.dart';
import 'asset_image.dart';

/// A widget that displays an image from a network URL with optional properties
/// for customization such as border radius, color overlay, gradient, and more.
///
/// If the provided [url] is not a valid image URL, it defaults to showing
/// as a loading indicator while the image is being fetched.
class NetWorkImageWidget extends StatelessWidget {
  /// Creates an [NetWorkImageWidget] widget.
  ///
  /// The [url] is required and specifies the image URL to load. If the [url]
  /// is invalid or null, a fallback SVG asset is displayed.
  const NetWorkImageWidget({
    super.key,
    required this.url,
    this.height,
    this.width,
    this.borderRadius,
    this.color,
    this.withGradient,
    this.fit,
    this.border,
    this.alignment,
    this.withCaching = true,
    this.errorWidget,
    this.padding,
  });

  /// The URL of the image to display.
  final String? url;

  /// Indicates whether to apply a gradient overlay to the image.
  final bool? withGradient;

  /// The height of the image.
  final double? height;

  /// The color overlay for the image.
  final Color? color;

  /// The width of the image.
  final double? width;

  /// The border radius to apply to the image.
  final BorderRadiusGeometry? borderRadius;

  /// The box-fit property to control how the image should fit within its bounds.
  final BoxFit? fit;

  /// The border to apply to the image container.
  final Border? border;

  /// The alignment of the image within its container.
  final AlignmentGeometry? alignment;

  final bool withCaching;

  final EdgeInsetsGeometry? padding;

  final Widget? errorWidget;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        border: border,
        borderRadius: borderRadius,
      ),
      padding: padding,
      alignment: alignment,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(8.r),
        child: url.isImageUrl()
            ? withCaching
                  ? CachedNetworkImage(
                      imageUrl: url!,
                      fit: fit ?? BoxFit.contain,
                      height: height,
                      width: width,
                      placeholder: (context, url) => _buildPlaceholder(),
                      errorWidget: (context, url, error) =>
                          errorWidget ?? _buildErrorWidget(),
                    )
                  : Image.network(
                      url!,
                      fit: fit ?? BoxFit.contain,
                      height: height,
                      width: width,
                      loadingBuilder: (context, child, loadingProgress) =>
                          _buildPlaceholder(),
                      errorBuilder: (context, error, stackTrace) =>
                          errorWidget ?? _buildErrorWidget(),
                    )
            : errorWidget ?? _buildErrorWidget(),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      alignment: Alignment.center,
      height: height,
      width: width,
      decoration: BoxDecoration(borderRadius: borderRadius),
      child: SkeletonWidget(
        child: Container(
          height: height ?? double.infinity,
          width: width ?? double.infinity,
          color: AppColors.appDivider,
        ),
      ),
    );
  }

  /// Builds the fallback error widget when the image fails to load or URL is invalid.
  Widget _buildErrorWidget() {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: SizedBox(
        height: height,
        width: width,
        child: DecoratedBox(
          decoration: BoxDecoration(color: AppColors.whiteColor),
          child: SvgAsset(AppIcons.exclamationMark,fit: BoxFit.contain,),
        ),
      ),
    );
  }
}
