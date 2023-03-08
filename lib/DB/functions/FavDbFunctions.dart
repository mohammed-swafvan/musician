import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavDbFun {
  static bool isInitialized = false;
  static final musicDb = Hive.box<int>('FavDb');
  static ValueNotifier<List<SongModel>> favSongsNotifier = ValueNotifier([]);

  static initialize(List<SongModel> songs) {
    for (SongModel song in songs) {
      if (isFav(song)) {
        favSongsNotifier.value.add(song);
      }
    }
    isInitialized = true;
  }

  static isFav(SongModel song) {
    if (musicDb.values.contains(song.id)) {
      return true;
    }
    return false;
  }

  static addSongs(SongModel song) async {
    musicDb.add(song.id);
    favSongsNotifier.value.add(song);
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    FavDbFun.favSongsNotifier.notifyListeners();
  }

  static deleteSong(int id) async {
    int deleteKey = 0;
    if (!musicDb.values.contains(id)) {
      return;
    }
    final Map<dynamic, int> favMap = musicDb.toMap();
    favMap.forEach((key, value) {
      if (value == id) {
        deleteKey = key;
      }
    });
    musicDb.delete(deleteKey);
    favSongsNotifier.value.removeWhere((song) => song.id == id);
  }

  static clear() async {
    FavDbFun.favSongsNotifier.value.clear();
  }
}
