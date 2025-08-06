import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
  static Future<bool> requestLocationAndCamera() async {
    final statuses = await [
      Permission.location,
      Permission.camera,
    ].request();

    return statuses[Permission.location]!.isGranted &&
        statuses[Permission.camera]!.isGranted;
  }
}
