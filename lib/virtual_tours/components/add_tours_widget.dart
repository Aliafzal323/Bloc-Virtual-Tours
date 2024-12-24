import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtual_tours_bloc/virtual_tours/cubit/virtual_tours_cubit.dart';
import 'package:virtual_tours_bloc/virtual_tours/cubit/virtual_tours_state.dart';

class AddMoreToursWidget extends StatelessWidget {
  const AddMoreToursWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VirtualToursCubit, VirtualToursState>(
      buildWhen: (previous, current) =>
          previous.virtualTours != current.virtualTours ||
          previous.isTourEnabled != current.isTourEnabled,
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context.read<VirtualToursCubit>().propertyVirtualTours();
          },
          child: const Text(
            '+ Add More',
            style: TextStyle(
              color: Colors.greenAccent,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}
