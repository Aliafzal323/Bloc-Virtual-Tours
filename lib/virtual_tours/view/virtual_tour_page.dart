part of 'view.dart';

class VirtualToursPage extends StatelessWidget {
  const VirtualToursPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VirtualToursCubit(),
      child: const VirtualToursScreen(),
    );
  }
}
