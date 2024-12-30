import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetworkImageWidget extends StatelessWidget {
  const NetworkImageWidget({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.borderRadius,
    this.child,
  });
  final String imageUrl;
  final double? height;
  final double? width;
  final BorderRadiusGeometry? borderRadius;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(0),
      child: CachedNetworkImage(
        width: width ?? double.infinity,
        height: height ?? 150,
        fit: BoxFit.fill,
        imageUrl: imageUrl,
        progressIndicatorBuilder: (context, url, downloadProgress) {
          return child ??
              Center(
                child: CircularProgressIndicator(
                  value: downloadProgress.progress,
                ),
              );
        },
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
