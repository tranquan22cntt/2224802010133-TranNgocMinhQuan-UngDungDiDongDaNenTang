import 'package:just_audio/just_audio.dart';

class AudioPlayerService {
  final AudioPlayer player = AudioPlayer();

  Stream<Duration> get positionStream => player.positionStream;

  Stream<Duration?> get durationStream => player.durationStream;

  Stream<bool> get playingStream => player.playingStream;

  Future<void> load(String path) async {
    await player.setFilePath(path);
  }

  Future<void> play() async {
    await player.play();
  }

  Future<void> pause() async {
    await player.pause();
  }

  Future<void> stop() async {
    await player.stop();
  }

  Future<void> seek(Duration position) async {
    await player.seek(position);
  }

  Future<void> setLoopMode(LoopMode mode) async {
    await player.setLoopMode(mode);
  }

  void dispose() {
    player.dispose();
  }
}