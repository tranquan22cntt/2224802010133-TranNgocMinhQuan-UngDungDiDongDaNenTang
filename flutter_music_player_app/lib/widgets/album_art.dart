import 'package:flutter/material.dart';

class AlbumArt extends StatelessWidget {
  final double size;

  const AlbumArt({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Icon(
        Icons.music_note,
        size: 100,
      ),
    );
  }
}