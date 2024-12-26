import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'video_player_state.dart';

class VideoPlayerCubit extends Cubit<VideoPlayerState> {
  VideoPlayerCubit() : super(VideoPlayerInitial());
}
