import 'dart:io';

import 'package:common/constants/asset_icons.dart';
import 'package:common/theme/theme.dart';
import 'package:common/widgets/asset_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:virtual_tours_bloc/video_player/Media_cubit/add_media_cubit.dart';
import 'package:virtual_tours_bloc/video_player/Media_cubit/add_media_state.dart';
import 'package:virtual_tours_bloc/virtual_tours/components/custom_color_container.dart';

// PropertyVideoScreen.dart
class PropertyVideoScreen extends StatefulWidget {
  const PropertyVideoScreen({
    super.key,
    required this.videoPath,
  });

  final String videoPath;
  // final List<String> videos;

  @override
  State<PropertyVideoScreen> createState() => _PropertyVideoScreenState();
}

class _PropertyVideoScreenState extends State<PropertyVideoScreen> {
  VideoPlayerController? videoController;
  bool _initialized = false;
  bool _disposed = false;

  @override
  void initState() {
    super.initState();
    _playInitialVideo();
  }

  void _playInitialVideo() {
    final cubit = context.read<AddMediaCubit>();
    final currentIndex = cubit.state.currentVideoIndex;
    if (currentIndex >= 0) {
      _onTapVideo(currentIndex);
    }
  }

  void _onTapVideo(int index) {
    final cubit = context.read<AddMediaCubit>();
    cubit.playVideo(index);
    final controller = VideoPlayerController.networkUrl(
      Uri.parse(cubit.state.videoList[index]),
    );
    videoController?.dispose();
    videoController = controller;

    controller.initialize().then((_) {
      setState(() {
        _initialized = true;
      });
    });
  }

  Future<void> onControllerUpdate() async {
    if (_disposed) {
      return;
    }
    final controller = videoController;
    if (controller == null) {
      return;
    }
    if (!controller.value.isInitialized) {
      return;
    }
    final playing = controller.value.isPlaying;
    _initialized = playing;
  }

  @override
  void dispose() {
    _disposed = true;
    videoController?.pause();
    videoController?.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddMediaCubit, AddMediaState>(
      buildWhen: (previous, current) =>
          previous.videoList != current.videoList ||
          previous.currentVideoIndex != current.currentVideoIndex,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: context.grey900,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const _PopVideoWidget(),
                      videoPlayView(context),
                      videoPausePlay(),
                      previousVideoButton(state),
                      nextVideoButton(state),
                    ],
                  ),
                ),
                // _BottomVideoWidget(
                //   currentIndex: state.currentVideoIndex,
                //   onThumbnailTap: (index) {
                //     _onTapVideo(
                //       index,
                //     );
                // },
                // ),
              ],
            ),
          ),
        );
      },
    );
  }

  Positioned nextVideoButton(AddMediaState addMediaState) {
    return Positioned(
      right: 16,
      child: GestureDetector(
        onTap: () async {
          final index = addMediaState.currentVideoIndex + 1;
          if (index < addMediaState.videoList.length) {
            _onTapVideo(index);
          }
        },
        child: const CustomColorContainer(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          padding: EdgeInsets.all(14),
          child: AssetIcon.multicolor(
            AssetIcons.min_arrow_right,
            size: 12,
          ),
        ),
      ),
    );
  }

  Positioned previousVideoButton(AddMediaState addMediaState) {
    return Positioned(
      left: 16,
      child: GestureDetector(
        onTap: () async {
          final index = addMediaState.currentVideoIndex - 1;
          if (index >= 0) {
            _onTapVideo(index);
          }
        },
        child: const CustomColorContainer(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          padding: EdgeInsets.all(14),
          child: AssetIcon.multicolor(
            AssetIcons.min_arrow_left,
            size: 12,
          ),
        ),
      ),
    );
  }

  Positioned videoPausePlay() {
    return Positioned(
      child: GestureDetector(
        onTap: () async {
          if (videoController != null) {
            if (videoController!.value.isPlaying) {
              await videoController?.pause();
            } else {
              await videoController?.play();
            }
            setState(() {});
          }
        },
        child: CustomColorContainer(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          padding: const EdgeInsets.all(14),
          child: AssetIcon.multicolor(
            videoController?.value.isPlaying == true
                ? AssetIcons.ac_icon
                : AssetIcons.play_icon,
            size: 12,
          ),
        ),
      ),
    );
  }

  Widget videoPlayView(BuildContext context) {
    final controller = videoController;
    if (controller != null && controller.value.isInitialized) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: VideoPlayer(controller),
      );
    } else {
      return const AspectRatio(
        aspectRatio: 16 / 9,
        child: Center(child: CircularProgressIndicator()),
      );
    }
  }
}

class _PopVideoWidget extends StatelessWidget {
  const _PopVideoWidget();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 48,
      right: 16,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: AssetIcon.monotone(
          AssetIcons.cross_mark,
          color: context.white,
          size: 40,
        ),
      ),
    );
  }
}

// class _BottomVideoWidget extends StatelessWidget {
//   const _BottomVideoWidget({
//     required this.onThumbnailTap,
//     required this.currentIndex,
//   });

//   final void Function(int) onThumbnailTap;
//   final int currentIndex;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 16),
//       decoration: BoxDecoration(
//         color: context.white.withOpacity(0.1),
//       ),
//       height: 140,
//       child: BlocBuilder<AddPropertyCubit, AddPropertyState>(
//         buildWhen: (previous, current) =>
//             previous.videoThumbnails != current.videoThumbnails,
//         builder: (context, state) {
//           return ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: state.videoThumbnails.length,
//             itemBuilder: (context, index) {
//               final thumbnail = state.videoThumbnails[index];

//               return GestureDetector(
//                 onTap: () {
//                   onThumbnailTap(index);
//                 },
//                 child: Container(
//                   margin: const EdgeInsets.only(right: 8),
//                   width: 120,
//                   height: 120,
//                   decoration: BoxDecoration(
//                     border: currentIndex == index
//                         ? Border.all(color: context.primary500, width: 2)
//                         : null,
//                     boxShadow: [
//                       BoxShadow(
//                         offset: const Offset(0, -6),
//                         blurRadius: 15,
//                         color: context.grey900.withOpacity(0.25),
//                       ),
//                     ],
//                     borderRadius: const BorderRadius.only(
//                       bottomLeft: Radius.circular(4),
//                       bottomRight: Radius.circular(4),
//                     ),
//                     image: DecorationImage(
//                       image: MemoryImage(thumbnail),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   child: const Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       CustomColorContainer(
//                         borderRadius: BorderRadius.all(Radius.circular(100)),
//                         padding: EdgeInsets.all(5),
//                         child: AssetIcon.multicolor(
//                           AssetIcons.play_icon,
//                           size: 10,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
