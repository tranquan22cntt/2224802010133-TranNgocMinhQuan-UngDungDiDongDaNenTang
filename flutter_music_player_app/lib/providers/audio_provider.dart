import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../models/song_model.dart';
import '../services/audio_player_service.dart';

class AudioProvider extends ChangeNotifier {
  final AudioPlayerService audioService =
  AudioPlayerService();

  List<SongModel> songs = [];

  int currentIndex = -1;

  bool isShuffle = false;

  LoopMode loopMode = LoopMode.off;

  SongModel? get currentSong {
    if (currentIndex < 0 ||
        currentIndex >= songs.length) {
      return null;
    }

    return songs[currentIndex];
  }

  bool get isPlaying =>
      audioService.player.playing;

  void setSongs(List<SongModel> newSongs) {
    songs = newSongs;
    notifyListeners();
  }

  Future<void> playSong(int index) async {
    if (index < 0 ||
        index >= songs.length) {
      return;
    }

    currentIndex = index;

    final song = songs[index];

    /// phát asset
    if (song.filePath.startsWith('assets/')) {
      await audioService.player.setAsset(
        song.filePath,
      );
    }

    /// phát file máy
    else {
      await audioService.load(
        song.filePath,
      );
    }

    await audioService.play();

    notifyListeners();
  }

  Future<void> playPause() async {
    if (audioService.player.playing) {
      await audioService.pause();
    } else {
      await audioService.play();
    }

    notifyListeners();
  }

  Future<void> next() async {
    if (songs.isEmpty) {
      return;
    }

    if (currentIndex < songs.length - 1) {
      await playSong(currentIndex + 1);
    } else {
      await playSong(0);
    }
  }

  Future<void> previous() async {
    if (songs.isEmpty) {
      return;
    }

    if (currentIndex > 0) {
      await playSong(currentIndex - 1);
    } else {
      await playSong(songs.length - 1);
    }
  }

  Future<void> seek(
      Duration position,
      ) async {
    await audioService.seek(position);
  }

  void toggleShuffle() {
    isShuffle = !isShuffle;

    notifyListeners();
  }

  Future<void> toggleRepeat() async {
    if (loopMode == LoopMode.off) {
      loopMode = LoopMode.all;
    }

    else if (loopMode == LoopMode.all) {
      loopMode = LoopMode.one;
    }

    else {
      loopMode = LoopMode.off;
    }

    await audioService.setLoopMode(
      loopMode,
    );

    notifyListeners();
  }

  @override
  void dispose() {
    audioService.dispose();

    super.dispose();
  }
}