import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavoriteProvider with ChangeNotifier {
  bool isInitialized = false;
  final musicDb = Hive.box<int>('FavDb');
  List<SongModel> favoriteSongs = [];

  initialize(List<SongModel> songs) {
    for (SongModel song in songs) {
      if (isFav(song)) {
        favoriteSongs.add(song);
      }
    }
    isInitialized = true;
  }

  isFav(SongModel song) {
    if (musicDb.values.contains(song.id)) {
      return true;
    }
    return false;
  }

  addSongs(SongModel song) async {
    musicDb.add(song.id);
    favoriteSongs.add(song);
  }

  deleteSong(int id) async {
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
    favoriteSongs.removeWhere((song) => song.id == id);
  }
}
