import 'dart:io';

import 'package:flutter/material.dart';

class VirtualTourThumbnail extends StatelessWidget {
  const VirtualTourThumbnail({super.key, required this.virtualTourPath});
  final String virtualTourPath;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -6),
            blurRadius: 15,
            color: Colors.grey.withOpacity(0.1),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(4),
          bottomRight: Radius.circular(4),
        ),
        child: Image.file(
          File(virtualTourPath),
          width: 120,
          height: 120,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
