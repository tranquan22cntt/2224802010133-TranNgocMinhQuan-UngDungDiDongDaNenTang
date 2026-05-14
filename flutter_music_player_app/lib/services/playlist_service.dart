import 'package:file_picker/file_picker.dart';

import '../models/song_model.dart';

class PlaylistService {
  Future<List<SongModel>> pickSongs() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
      allowedExtensions: ['mp3', 'm4a', 'wav', 'aac', 'flac', 'ogg'],
    );

    if (result == null) {
      return [];
    }

    return result.paths
        .whereType<String>()
        .map((path) => SongModel.fromFilePath(path))
        .toList();
  }
}