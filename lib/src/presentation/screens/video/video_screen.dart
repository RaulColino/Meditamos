import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meditamos/src/presentation/utils/videoplayer/videoplayer.dart';


class VideoScreen extends ConsumerWidget {
  const VideoScreen({
    Key? key,
    required this.videoId,
    required this.title,
  }) : super(key: key);

  final String videoId;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String videoIdentifier = videoId;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        elevation: 0,
      ),
      body: displayVideoPlayerBody(videoId),
    );
  }

  Widget displayVideoPlayerBody(String videoId) {
    return Container();
    // return VideoPlayer(
    //   videoId: videoId, //videoId: '40648169'
    //   allowFullScreen:
    //       true, //The parameter minSdkVersion 16 needs to be changed inside ./android/app/build.gradle.
    // );
  }
}
