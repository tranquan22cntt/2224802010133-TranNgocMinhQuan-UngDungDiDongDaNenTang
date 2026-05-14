class SongModel {
  final String id;
  final String title;
  final String artist;
  final String filePath;
  final Duration duration;

  SongModel({
    required this.id,
    required this.title,
    required this.artist,
    required this.filePath,
    required this.duration,
  });

  factory SongModel.fromFilePath(String path) {
    final fileName = path.split('\\').last.split('/').last;

    return SongModel(
      id: path,
      title: fileName,
      artist: 'Unknown Artist',
      filePath: path,
      duration: Duration.zero,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'filePath': filePath,
      'duration': duration.inMilliseconds,
    };
  }

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
      id: json['id'],
      title: json['title'],
      artist: json['artist'],
      filePath: json['filePath'],
      duration: Duration(
        milliseconds: json['duration'] ?? 0,
      ),
    );
  }
}