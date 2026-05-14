import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/song_model.dart';

class StorageService {
  static const String songsKey = 'songs';

  Future<void> saveSongs(List<SongModel> songs) async {
    final prefs = await SharedPreferences.getInstance();

    final data = songs.map((song) => song.toJson()).toList();

    await prefs.setString(songsKey, jsonEncode(data));
  }

  Future<List<SongModel>> loadSongs() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString(songsKey);

    if (data == null) {
      return [];
    }

    final List list = jsonDecode(data);

    return list.map((item) => SongModel.fromJson(item)).toList();
  }
}