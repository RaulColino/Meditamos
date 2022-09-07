import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meditamos/src/domain/entities/video.dart';
import 'package:meditamos/src/presentation/utils/videoplayer/videoplayer.dart';

class VideoScreen extends ConsumerWidget {
  const VideoScreen({
    Key? key,
    required this.video,
  }) : super(key: key);

  final Video video;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String videoIdentifier = video.videoId;
    return Scaffold(
      appBar: AppBar(
        title: Text(video.title),
        elevation: 0,
      ),
      body: displayVideoPlayerBody(video.videoId, context),
    );
  }

  Widget displayVideoPlayerBody(String videoId, BuildContext context) {
    //return Container();
    // return VideoPlayer(
    //   videoId: videoId, //videoId: '40648169'
    //   allowFullScreen:
    //       true, //The parameter minSdkVersion 16 needs to be changed inside ./android/app/build.gradle.
    // );
    return Center(
      child: Column(
        children: [
          Container(
            color: Colors.transparent,
            //height: MediaQuery.of(context).size.height * 0.8,
            height: 300,
            child: VideoPlayer(
              //videoId: '40648169',
              videoId: videoId,
              allowFullScreen:
                  true, //The parameter minSdkVersion 16 needs to be changed inside ./android/app/build.gradle.
            ),
          ),
        ],
      ),
    );
  }
}
