// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtual_tours_bloc/video_player/Media_cubit/add_media_state.dart';

class AddMediaCubit extends Cubit<AddMediaState> {
  AddMediaCubit()
      : super(
          const AddMediaState(),
        );
  void playVideo(int index) {
    emit(state.copyWith(currentVideoIndex: index));
  }

  void selectVideo(int index) {
    if (index >= 0 && index < state.videoList.length) {
      emit(state.copyWith(currentVideoIndex: index));
    }
  }

  void goToPreviousVideo() {
    if (state.currentVideoIndex > 0) {
      emit(
        state.copyWith(
          currentVideoIndex: state.currentVideoIndex - 1,
        ),
      );
    }
  }

  void gotToNextVideo() {
    if (state.currentVideoIndex > 0 &&
        state.currentVideoIndex < state.videoList.length - 1) {
      emit(
        state.copyWith(
          currentVideoIndex: state.currentVideoIndex - 1,
        ),
      );
    }
  }

  void setVideos(List<String> videos) {
    emit(
      state.copyWith(
        videoList: videos,
      ),
    );
  }

  void isUploading(bool value) {
    emit(
      state.copyWith(
        isUploading: value,
      ),
    );
  }
}
