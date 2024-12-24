import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class DottedBorderWidget extends StatelessWidget {
  const DottedBorderWidget({
    super.key,
    required this.title,
    // required this.height,
    this.isSubtitleTrue = false,
    required this.isFullWidth,
    required this.onTap,
    this.subtitle,
  });

  final String title;
  final bool isFullWidth;
  // final double height;
  final bool isSubtitleTrue;
  final VoidCallback onTap;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DottedBorder(
        borderType: BorderType.RRect,
        dashPattern: const [12],
        strokeWidth: 2,
        color: Colors.grey,
        // strokeCap: StrokeCap.square,
        radius: const Radius.circular(12),
        padding: isSubtitleTrue
            ? const EdgeInsets.all(32)
            : const EdgeInsets.symmetric(horizontal: 16, vertical: 58),
        child: SizedBox(
          width: isFullWidth
              ? double.infinity
              : MediaQuery.of(context).size.width * 0.35,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.file_copy),
              const SizedBox(
                height: 8,
              ),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              if (isSubtitleTrue)
                Text(
                  subtitle ?? '',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )
              else
                const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
