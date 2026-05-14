import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/audio_provider.dart';
import '../widgets/album_art.dart';
import '../widgets/player_controls.dart';
import '../widgets/progress_bar.dart';

class NowPlayingScreen extends StatelessWidget {
  const NowPlayingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AudioProvider>();
    final song = provider.currentSong;

    if (song == null) {
      return const Scaffold(
        body: Center(
          child: Text('No song playing'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AlbumArt(size: 220),
            const SizedBox(height: 30),
            Text(
              song.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(song.artist),
            const SizedBox(height: 30),
            const ProgressBar(),
            const SizedBox(height: 20),
            PlayerControls(provider: provider),
          ],
        ),
      ),
    );
  }
}