import 'package:flutter/material.dart';
import 'package:musician/controller/get_all_music_controller.dart';

class PlayControlsProvider with ChangeNotifier {
  bool songIsPlaying = true;

  bool get isPlaying => songIsPlaying;

  void playPause() {
    songIsPlaying = !songIsPlaying;
    notifyListeners();
  }

  void turnOnshuffleMode() {
    GetAllSongController.audioPlayer.setShuffleModeEnabled(true);
  }

  void turnOffshuffleMode() {
    GetAllSongController.audioPlayer.setShuffleModeEnabled(false);
  }

  void songPause() {
    GetAllSongController.audioPlayer.pause();
  }

  void songPlay() {
    GetAllSongController.audioPlayer.play();
  }
}
