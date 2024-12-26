import 'package:equatable/equatable.dart';

class AddMediaState extends Equatable {
  const AddMediaState({
    this.currentVideoIndex = 0,
    this.videoList = const [
      'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
      'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
      'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'
    ],
    this.isUploading = false,
  });
  final int currentVideoIndex;
  final bool isUploading;
  final List<String> videoList;

  AddMediaState copyWith({
    int? currentVideoIndex,
    List<String>? videoList,
    bool? isUploading,
  }) {
    return AddMediaState(
      currentVideoIndex: currentVideoIndex ?? this.currentVideoIndex,
      videoList: videoList ?? this.videoList,
      isUploading: isUploading ?? this.isUploading,
    );
  }

  @override
  List<Object?> get props => [
        currentVideoIndex,
        videoList,
        isUploading,
      ];
}
