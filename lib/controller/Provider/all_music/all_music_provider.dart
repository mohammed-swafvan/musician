import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AllMusicProvider with ChangeNotifier {
  // StreamController to broadcast changes to the list of MP3 songs
  final _mp3SongsController = StreamController<List<SongModel>>.broadcast();
  // Getter for the stream
  Stream<List<SongModel>> get mp3SongsStream => _mp3SongsController.stream;

  final OnAudioQuery audioQuery = OnAudioQuery();
  void requestStoragePermission() async {
    if (!kIsWeb) {
      bool permissionStatus = await audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await audioQuery.permissionsRequest();
      }else{
        await queryMp3Songs();
      }
      notifyListeners();
    }
    
  }

  Future<void> queryMp3Songs() async {
    List<SongModel> allsongs = await audioQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
    List<SongModel> mp3Songs = allsongs.where((song) {
      String extension = song.fileExtension.split('.').last.toLowerCase();
      return extension == "mp3";
    }).toList();
    _mp3SongsController.add(mp3Songs);
    notifyListeners();
  }
}
