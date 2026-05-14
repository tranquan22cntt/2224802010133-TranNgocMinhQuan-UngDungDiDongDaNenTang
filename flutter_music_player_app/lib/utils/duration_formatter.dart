class DurationFormatter {
  static String format(Duration duration) {
    String twoDigits(int n) {
      return n.toString().padLeft(2, '0');
    }

    final minutes = twoDigits(
      duration.inMinutes.remainder(60),
    );

    final seconds = twoDigits(
      duration.inSeconds.remainder(60),
    );

    return '$minutes:$seconds';
  }
}