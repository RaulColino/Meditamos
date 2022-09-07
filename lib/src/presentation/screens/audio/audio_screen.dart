import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meditamos/src/domain/entities/audio.dart';
import 'package:meditamos/src/presentation/widgets/audioplayer/control_buttons.dart';
import 'package:meditamos/src/presentation/widgets/audioplayer/seekbar.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:rxdart/rxdart.dart';

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}

class AudioScreen extends ConsumerStatefulWidget {
  const AudioScreen({Key? key, required this.audio}) : super(key: key);

  final Audio audio;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AudioScreenState();
}

class _AudioScreenState extends ConsumerState<AudioScreen> {
  final AudioPlayer _player = AudioPlayer();
  late final audioSource;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Release the player's resources when not in use. We use "stop" so that
      // if the app resumes later, it will still remember what position to
      // resume from.
      _player.stop();
    }
  }

  Future<void> _init() async {
    //Get audio url from Audio object passed to AudioScreen
    final String audioUrl = widget.audio.url;
    // Listen to errors during playback.
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    // Try to load audio from a source and catch any errors.
    try {
      await _player.setAudioSource(AudioSource.uri(Uri.parse(audioUrl)));
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }

  /// Collects the data useful for displaying in a seek bar, using a handy
  /// feature of rx_dart to combine the 3 streams of interest into one.
  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _player.positionStream, //position of audio playing
        _player.bufferedPositionStream, //length of audio downloaded
        _player.durationStream, //total audio length
        (position, bufferedPosition, duration) => PositionData(position, bufferedPosition, duration ?? Duration.zero),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.audio.title)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              PhosphorIcons.downloadSimple,
              size: 30,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 180),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //Control buttons. play/pause button, backward10sec,forward10sec, volume/speed sliders, etc.
              Padding(
                padding: const EdgeInsets.only(bottom: 1.0),
                child: ControlButtons(_player),
              ),
              //Seek bar. Using StreamBuilder, this widget rebuilds each time the position, buffered position or duration changes.
              StreamBuilder<PositionData>(
                stream: _positionDataStream,
                builder: (context, snapshot) {
                  
                  final positionData = snapshot.data;
                  final progress = positionData?.position?? Duration.zero;
                  final duration = positionData?.duration?? Duration.zero;
                  final downloadProgress =  positionData?.bufferedPosition ?? Duration.zero;

                  return SeekBar(
                    duration: duration,
                    position: progress,
                    bufferedPosition: downloadProgress,
                    onChangeEnd: _player.seek,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
