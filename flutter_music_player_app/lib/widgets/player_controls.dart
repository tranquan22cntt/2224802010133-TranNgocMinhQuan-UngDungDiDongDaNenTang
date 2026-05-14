import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../providers/audio_provider.dart';

class PlayerControls extends StatelessWidget {
  final AudioProvider provider;

  const PlayerControls({
    super.key,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(
            Icons.shuffle,
            color: provider.isShuffle ? Colors.green : null,
          ),
          onPressed: provider.toggleShuffle,
        ),

        IconButton(
          iconSize: 42,
          icon: const Icon(Icons.skip_previous),
          onPressed: provider.previous,
        ),

        StreamBuilder<bool>(
          stream: provider.audioService.playingStream,
          initialData: provider.audioService.player.playing,
          builder: (context, snapshot) {
            final isPlaying = snapshot.data ?? false;

            return IconButton(
              iconSize: 64,
              icon: Icon(
                isPlaying
                    ? Icons.pause_circle
                    : Icons.play_circle,
              ),
              onPressed: provider.playPause,
            );
          },
        ),

        IconButton(
          iconSize: 42,
          icon: const Icon(Icons.skip_next),
          onPressed: provider.next,
        ),

        IconButton(
          icon: Icon(
            provider.loopMode == LoopMode.one
                ? Icons.repeat_one
                : Icons.repeat,
            color: provider.loopMode == LoopMode.off
                ? null
                : Colors.green,
          ),
          onPressed: provider.toggleRepeat,
        ),
      ],
    );
  }
}