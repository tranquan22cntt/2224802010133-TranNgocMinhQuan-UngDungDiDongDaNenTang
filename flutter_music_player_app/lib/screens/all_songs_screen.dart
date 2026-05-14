import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/playlist_provider.dart';
import '../widgets/song_tile.dart';

class AllSongsScreen extends StatelessWidget {
  const AllSongsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PlaylistProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Songs'),
      ),
      body: ListView.builder(
        itemCount: provider.songs.length,
        itemBuilder: (context, index) {
          return SongTile(
            song: provider.songs[index],
            onTap: () {},
          );
        },
      ),
    );
  }
}