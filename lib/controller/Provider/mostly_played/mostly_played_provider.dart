import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musician/presentation/home/widgets/all_music.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MostlyPlayedProvider with ChangeNotifier {
  List<SongModel> mostPlayedSongs = [];
  List<dynamic> mostlyPlayed = [];

  Future<void> addSongsToMostly(songs) async {
    final mostPlayedDb = await Hive.openBox('MostlyPlayed');
    await mostPlayedDb.add(songs);
    getMostPlayedSongs();
    notifyListeners();
  }

  Future<void> getMostPlayedSongs() async {
    final mostPlayedDb = await Hive.openBox('MostlyPlayed');
    mostlyPlayed = mostPlayedDb.values.toList();
    displayMostPlayedSongs();
    notifyListeners();
  }

  Future<List> displayMostPlayedSongs() async {
    final mostPlayedDb = await Hive.openBox('MostlyPlayed');
    final mostPlayedItems = mostPlayedDb.values.toList();
    mostPlayedSongs.clear();
    int count = 0;
    for (var i = 0; i < mostPlayedItems.length; i++) {
      for (var k = 0; k < mostPlayedItems.length; k++) {
        if (mostPlayedItems[i] == mostPlayedItems[k]) {
          count = count + 1;
        }
      }
      if (count > 4) {
        for (var j = 0; j < startSong.length; j++) {
          if (mostPlayedItems[i] == startSong[j].id) {
            mostPlayedSongs.add(startSong[j]);
            mostlyPlayed.add(startSong[j]);
          }
        }
        count = 0;
      }
    }
    return mostlyPlayed;
  }
}
