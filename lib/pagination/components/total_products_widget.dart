import 'package:flutter/material.dart';

class TotalProductsWidget extends StatelessWidget {
  const TotalProductsWidget({
    super.key,
    required this.totalProducts,
  });

  final int totalProducts;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 8,
      left: 8,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          'Total Products: $totalProducts',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
