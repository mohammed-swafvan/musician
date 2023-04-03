import 'package:flutter/material.dart';
import 'package:musician/presentation/home/widgets/all_music.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchProvider with ChangeNotifier {
  List<SongModel> foundedSongs = [];
  List<SongModel> allSongs = [];

  final audioQuery = OnAudioQuery();
  void songsAreLoading() async {
    allSongs = startSong;

    foundedSongs = allSongs;
    notifyListeners();
  }

  void updatedList(String enteredText) async {
    List<SongModel> results = [];
    if (enteredText.isEmpty) {
      results = allSongs;
    } else {
      results = allSongs.where((element) => 
      element.displayNameWOExt.toLowerCase().contains(enteredText.toLowerCase())
      ).toList();
    }
    foundedSongs = results;
    notifyListeners();
  }
}
