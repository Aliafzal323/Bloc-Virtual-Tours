import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtual_tours_bloc/video_player/Media_cubit/add_media_cubit.dart';
import 'package:virtual_tours_bloc/video_player/view/video_player_view.dart';

class VideoPlayerPage extends StatelessWidget {
  const VideoPlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddMediaCubit(),
      child: const PropertyVideoScreen(
          videoPath:
              'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'),
    );
  }
}
