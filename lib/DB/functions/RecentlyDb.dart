import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musician/Screens/AllMusic/AllMusic.dart';
import 'package:on_audio_query/on_audio_query.dart';

class RecentlyDb extends ChangeNotifier {
  static ValueNotifier<List<SongModel>> recentlyPlayedNotifier = ValueNotifier([]);
  static List<dynamic> recentlyPlay = [];

  static Future<void> addSongToRecently(song) async {
    final recentlyplayDb = await Hive.openBox('RecentlyPlay');
    await recentlyplayDb.add(song);
    getRecentlyPlayedSongs();
    recentlyPlayedNotifier.notifyListeners();
  }

  static Future<void> getRecentlyPlayedSongs() async {
    final recentlyplayDb = await Hive.openBox('RecentlyPlay');
    recentlyPlay = recentlyplayDb.values.toList();
    displayRecentlyPlayedSongs();
    recentlyPlayedNotifier.notifyListeners();
  }

  static Future<void> displayRecentlyPlayedSongs() async {
    final recentlyplayDb = await Hive.openBox('RecentlyPlay');
    final recentlyPlayedItems = recentlyplayDb.values.toList();
    recentlyPlayedNotifier.value.clear();
    recentlyPlay.clear();
    for (int i = 0; i < recentlyPlayedItems.length; i++) {
      for (int j = 0; j < startSong.length; j++) {
          if (recentlyPlayedItems[i] == startSong[j].id) {
            recentlyPlayedNotifier.value.add(startSong[j]);
            recentlyPlay.add(startSong[j]);
          }
      }
    }
  }
}
