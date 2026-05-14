import 'package:flutter/material.dart';

import '../models/song_model.dart';
import '../services/playlist_service.dart';
import '../services/storage_service.dart';

class PlaylistProvider extends ChangeNotifier {
  final PlaylistService playlistService = PlaylistService();

  final StorageService storageService = StorageService();

  List<SongModel> songs = [];

  Future<void> loadSavedSongs() async {
    songs = await storageService.loadSongs();
    notifyListeners();
  }

  Future<void> pickSongs() async {
    final pickedSongs = await playlistService.pickSongs();

    if (pickedSongs.isNotEmpty) {
      songs = pickedSongs;
      await storageService.saveSongs(songs);
      notifyListeners();
    }
  }
}