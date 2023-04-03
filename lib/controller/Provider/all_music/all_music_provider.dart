import 'package:flutter/foundation.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class AllMusicProvider with ChangeNotifier {
  final OnAudioQuery audioQuery = OnAudioQuery();
  void requestStoragePermission() async {
    if (!kIsWeb) {
      bool permissionStatus = await audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await audioQuery.permissionsRequest();
      }
      Permission.storage.request();
      notifyListeners();
    }
  }
}
