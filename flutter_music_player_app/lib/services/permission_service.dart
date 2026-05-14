import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<void> requestPermission() async {
    await Permission.storage.request();
    await Permission.audio.request();
  }
}