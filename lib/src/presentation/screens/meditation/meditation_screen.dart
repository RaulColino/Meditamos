import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:meditamos/src/presentation/screens/video/video_screen.dart';
import 'package:meditamos/src/presentation/utils/routing/app_router.dart';

import '../../../domain/entities/video.dart';

class MeditationScreen extends ConsumerWidget {
  const MeditationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircularButton(text: "5 min"),
                CircularButton(text: "10 min"),
                CircularButton(text: "15 min"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CircularButton extends StatelessWidget {
  const CircularButton({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;
  final String id = "40648169";
  final String title = "examplevideo";

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => context.pushNamed(
        AppRoutes.audioScreen.name,
        params: {'title': "pid"},
      ),
      // onPressed: () => context.pushNamed(
      //   AppRoutes.videoScreen.name,
      //   params: {'id': "123", 'title': "pid"},
      // ),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(80, 80),
        maximumSize: Size(400, 400),
        shape: CircleBorder(),
      ),
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
