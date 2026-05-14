import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/song_model.dart';
import '../providers/audio_provider.dart';
import '../widgets/mini_player.dart';
import '../widgets/song_tile.dart';
import 'now_playing_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  List<SongModel> get assetSongs => [
    SongModel(
      id: '1',
      title: 'Am Tham Ben Em',
      artist: 'Son Tung M-TP',
      filePath: 'assets/audio/am_tham_ben_em.mp3',
      duration: Duration.zero,
    ),
    SongModel(
      id: '2',
      title: 'Noi Nay Co Anh',
      artist: 'Son Tung M-TP',
      filePath: 'assets/audio/noi_nay_co_anh.mp3',
      duration: Duration.zero,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final audioProvider = context.watch<AudioProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Music App'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: assetSongs.length,
              itemBuilder: (context, index) {
                final song = assetSongs[index];

                return SongTile(
                  song: song,
                  onTap: () async {
                    audioProvider.setSongs(assetSongs);

                    await audioProvider.playSong(index);

                    if (!context.mounted) return;

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const NowPlayingScreen(),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const MiniPlayer(),
        ],
      ),
    );
  }
}