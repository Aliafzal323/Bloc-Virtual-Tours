import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:virtual_tours_bloc/virtual_tours/cubit/virtual_tours_state.dart';

class VirtualToursCubit extends Cubit<VirtualToursState> {
  VirtualToursCubit() : super(const VirtualToursState());

  final ImagePicker _pickImage = ImagePicker();

  Future<void> propertyVirtualTours() async {
    try {
      final List<XFile>? pickedFiles = await _pickImage.pickMultiImage();
      if (pickedFiles != null && pickedFiles.isNotEmpty) {
        final List<String> pickedPaths =
            pickedFiles.map((file) => file.path).toList();

        emit(
          state.copyWith(
            virtualTours: [...state.virtualTours, ...pickedPaths],
            isTourEnabled: true,
          ),
        );
      }
    } catch (e) {
      print('Error picking images: $e');
    }
  }

  void removePropertyVirtualTour(int index) {
    final updatedToursList = List.of(state.virtualTours);

    updatedToursList.removeAt(index);

    emit(
      state.copyWith(
        virtualTours: updatedToursList,
      ),
    );
  }
}
