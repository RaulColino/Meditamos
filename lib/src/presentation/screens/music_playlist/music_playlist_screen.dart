import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:meditamos/src/domain/entities/audio.dart';
import 'package:meditamos/src/presentation/utils/routing/app_router.dart';
import 'package:meditamos/src/presentation/utils/theme/meditamos_colors.dart';

final List<Audio> soundtracks = [
  Audio(
      url: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-13.mp3",
      title: "audio1",
      author: "authorA"),
  Audio(
      url:
          "https://a.storyblok.com/f/102170/x/833b0a0e84/audiomeditation1compressed.mp3",
      title: "audio2",
      author: "authorB"),
  Audio(
      url: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-13.mp3",
      title: "audio3",
      author: "authorC"),
  Audio(
      url:
          "https://a.storyblok.com/f/102170/x/833b0a0e84/audiomeditation1compressed.mp3",
      title: "audio4",
      author: "authorA"),
];

class MusicPlaylistScreen extends ConsumerWidget {
  const MusicPlaylistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: soundtracks.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () => context.pushNamed(
              AppRoutes.audioScreen.name,
              extra: soundtracks[index],
            ),
            //tileColor: MeditamosColors.gray,
            title: Text(soundtracks[index].title),
            subtitle: Text(soundtracks[index].author),
          );
        },
      ),
    );
  }
}
