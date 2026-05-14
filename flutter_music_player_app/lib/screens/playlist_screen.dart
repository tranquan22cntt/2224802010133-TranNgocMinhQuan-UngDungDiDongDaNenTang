import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/playlist_provider.dart';
import '../widgets/song_tile.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PlaylistProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Playlist'),
      ),
      body: provider.songs.isEmpty
          ? const Center(
        child: Text('No songs in playlist'),
      )
          : ListView.builder(
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