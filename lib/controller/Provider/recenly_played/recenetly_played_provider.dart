import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musician/presentation/home/widgets/all_music.dart';
import 'package:on_audio_query/on_audio_query.dart';

class RecentlyPlayedProvider with ChangeNotifier {
  List<SongModel> recentlyPlay = [];

  Future<void> addSongToRecently(song) async {
    final recentlyplayDb = await Hive.openBox('RecentlyPlay');
    await recentlyplayDb.add(song);
    getRecentlyPlayedSongs();
    notifyListeners();
  }

  Future<void> getRecentlyPlayedSongs() async {
    displayRecentlyPlayedSongs();
  }

  Future<void> displayRecentlyPlayedSongs() async {
    final recentlyplayDb = await Hive.openBox('RecentlyPlay');
    final recentlyPlayedItems = recentlyplayDb.values.toList();
    recentlyPlay.clear();
    for (int i = 0; i < recentlyPlayedItems.length; i++) {
      for (int j = 0; j < startSong.length; j++) {
        if (recentlyPlayedItems[i] == startSong[j].id) {
          recentlyPlay.add(startSong[j]);
        }
      }
    }
    notifyListeners();
  }
}
