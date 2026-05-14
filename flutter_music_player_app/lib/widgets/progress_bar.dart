import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/audio_provider.dart';
import '../utils/duration_formatter.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AudioProvider>();
    final player = provider.audioService.player;

    return StreamBuilder<Duration>(
      stream: player.positionStream,
      builder: (context, snapshot) {
        final position = snapshot.data ?? Duration.zero;
        final duration = player.duration ?? Duration.zero;

        final max = duration.inSeconds == 0
            ? 1.0
            : duration.inSeconds.toDouble();

        final value = position.inSeconds
            .toDouble()
            .clamp(0.0, max);

        return Column(
          children: [
            Slider(
              min: 0,
              max: max,
              value: value,
              onChanged: (value) {
                provider.seek(
                  Duration(seconds: value.toInt()),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(DurationFormatter.format(position)),
                Text(DurationFormatter.format(duration)),
              ],
            ),
          ],
        );
      },
    );
  }
}