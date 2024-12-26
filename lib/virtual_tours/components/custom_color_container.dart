import 'package:common/theme/theme.dart';
import 'package:flutter/material.dart';

class CustomColorContainer extends StatelessWidget {
  const CustomColorContainer({
    super.key,
    this.child,
    this.margin,
    this.color,
    this.borderColor,
    this.padding,
    this.onTap,
    this.borderRadius,
  });
  final Widget? child;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 16),
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor ?? context.transparent),
        color: color ?? context.grey50,
        borderRadius: borderRadius ?? BorderRadius.circular(4),
      ),
      child: GestureDetector(onTap: onTap, child: child),
    );
  }
}
