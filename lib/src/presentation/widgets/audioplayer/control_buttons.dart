import 'dart:math';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// Displays the play/pause button and volume/speed sliders.
class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  const ControlButtons(this.player, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double centerButtonsSize = 50.0;
    double sideButtonsSize = 30.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      //mainAxisSize: MainAxisSize.min,
      children: [
        //Rewind 10s
        IconButton(
          onPressed: () {
            int newPosition = max(0, player.position.inSeconds - 10);
            player.seek(Duration(seconds: newPosition));
          },
          icon: Icon(
            Icons.replay_10_rounded,
            size: centerButtonsSize * 0.75,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),

        /// This StreamBuilder rebuilds whenever the player state changes, which
        /// includes the playing/paused state and also the
        /// loading/buffering/ready state. Depending on the state we show the
        /// appropriate button or loading indicator.
        Container(
          height: 200,
          width: 130,
          //color: Colors.red,
          child: StreamBuilder<PlayerState>(
            stream: player.playerStateStream,
            builder: (context, snapshot) {
              final playerState = snapshot.data;
              final processingState = playerState?.processingState;
              final playing = playerState?.playing;
              if (processingState == ProcessingState.loading ||
                  processingState == ProcessingState.buffering) {
                //loading
                return Center(
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    width: 64.0,
                    height: 64.0,
                    child: const CircularProgressIndicator(),
                  ),
                );
              } else if (playing != true) {
                //play
                return CenterControlButton(
                  icon: PhosphorIcons.playFill,
                  centerButtonsSize: centerButtonsSize * 0.6,
                  containerSize: centerButtonsSize,
                  onClick: player.play,
                  showBorder: false,
                );
              } else if (processingState != ProcessingState.completed) {
                //pause
                return CenterControlButton(
                  icon: PhosphorIcons.pauseFill,
                  centerButtonsSize: centerButtonsSize * 0.6,
                  containerSize: centerButtonsSize,
                  onClick: player.pause,
                  showBorder: true,
                );
              } else {
                //replay
                return CenterControlButton(
                  icon: Icons.replay_rounded,
                  centerButtonsSize: centerButtonsSize,
                  containerSize: centerButtonsSize,
                  onClick: () => player.seek(Duration.zero),
                  showBorder: false,
                );
              }
            },
          ),
        ),

        //Skip 10s
        IconButton(
          onPressed: () {
            int newPosition = min(
              player.sequenceState?.currentSource?.duration?.inSeconds ?? 0,
              player.position.inSeconds + 10,
            );
            player.seek(Duration(seconds: newPosition));
          },
          icon: Icon(
            Icons.forward_10_rounded,
            size: centerButtonsSize * 0.75,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ],
    );
  }
}

class CenterControlButton extends StatelessWidget {
  const CenterControlButton({
    Key? key,
    required this.centerButtonsSize,
    required this.onClick,
    required this.showBorder,
    required this.icon,
    required this.containerSize,
  }) : super(key: key);

  final IconData icon;
  final double centerButtonsSize;
  final void Function()? onClick;
  final bool showBorder;
  final double containerSize;

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: AlignmentDirectional.center, children: [
      if (showBorder)
        Container(
          width: containerSize * 1.7,
          height: containerSize * 1.7,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
        ),
      Container(
        width: containerSize * 1.3,
        height: containerSize * 1.3,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onBackground,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          iconSize: centerButtonsSize,
          icon: Icon(
            icon,
            color: Theme.of(context).colorScheme.background,
          ),
          onPressed: onClick,
        ),
      ),
    ]);
  }
}
