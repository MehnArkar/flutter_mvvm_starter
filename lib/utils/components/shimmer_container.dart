import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_starter/config/theme/app_dimensions.dart';

/// Drop-in shimmer placeholder. Specify [width] and [height] in logical pixels.
///
/// ```dart
/// ShimmerContainer(width: double.maxFinite, height: 48)
/// ```
class ShimmerContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadiusGeometry? borderRadius;

  const ShimmerContainer({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
          borderRadius ?? BorderRadius.circular(AppDimensions.radiusSmall),
      child: FadeShimmer(
        width: width ?? 0,
        height: height ?? 0,
        highlightColor: Colors.grey[300]!,
        baseColor: Theme.of(context).colorScheme.surfaceDim,
      ),
    );
  }
}
