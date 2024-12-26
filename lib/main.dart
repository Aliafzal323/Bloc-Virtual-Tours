import 'package:flutter/material.dart';
import 'package:virtual_tours_bloc/selection_view/selection_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: SelectionPage());
  }
}
