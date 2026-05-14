import 'package:flutter/material.dart';

import '../models/song_model.dart';

class SongTile extends StatelessWidget {
  final SongModel song;

  final VoidCallback onTap;

  const SongTile({
    super.key,
    required this.song,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.music_note),

      title: Text(
        song.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),

      subtitle: Text(song.artist),

      onTap: onTap,
    );
  }
}