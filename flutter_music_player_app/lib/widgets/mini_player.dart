import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/audio_provider.dart';
import '../screens/now_playing_screen.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AudioProvider>();
    final song = provider.currentSong;

    if (song == null) {
      return const SizedBox.shrink();
    }

    return ListTile(
      tileColor: Colors.black26,
      leading: const Icon(Icons.music_note),
      title: Text(
        song.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: IconButton(
        icon: Icon(
          provider.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
        onPressed: provider.playPause,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const NowPlayingScreen(),
          ),
        );
      },
    );
  }
}