import 'package:flutter/material.dart';

class PlaylistCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const PlaylistCard({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.queue_music),
        title: Text(title),
        onTap: onTap,
      ),
    );
  }
}