import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musician/controller/core/themes/usually_colors.dart';
import 'package:musician/models/Song_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayListProvider with ChangeNotifier {
  List<SongsDataBase> playLists = [];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();

  final playListDb = Hive.box<SongsDataBase>('PlayListDb');

  Future<void> addPlayList(SongsDataBase value) async {
    final playlistDb = Hive.box<SongsDataBase>('PlayListDb');
    await playlistDb.add(value);
    playLists.add(value);
  }

  Future<void> getAllPlaylist() async {
    final playlistDb = Hive.box<SongsDataBase>('PlayListDb');
    playLists.clear();
    playLists.addAll(playlistDb.values);
  }

  Future<void> deletePlaylist(int index) async {
    final playlistDb = Hive.box<SongsDataBase>('PlayListDb');
    await playlistDb.deleteAt(index);
    getAllPlaylist();
  }

  void editPlaylist(int index, SongsDataBase value) {
    final playlistDb = Hive.box<SongsDataBase>('PlayListDb');
    playlistDb.putAt(index, value);
    getAllPlaylist();
  }

  void songsToPlayList(SongModel song, SongsDataBase playlist, BuildContext context) {
    playlist.add(song.id);
    final addedToPlayList = SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      behavior: SnackBarBehavior.floating,
      backgroundColor: componentsColor,
      content: Text(
        'Song Added',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.deepPurple[50]),
      ),
      duration: const Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(addedToPlayList);
    notifyListeners();
  }

  void songDeletedFromPlaylist(SongModel song, SongsDataBase playlist, BuildContext context) {
    playlist.deleteData(song.id);
    final removeFromPlaylist = SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      behavior: SnackBarBehavior.floating,
      backgroundColor: componentsColor,
      content: Text(
        'Song Removed',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.deepPurple[50]),
      ),
      duration: const Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(removeFromPlaylist);
    notifyListeners();
  }

  bool isContainInPlayList(SongsDataBase playList, SongModel item) {
    notifyListeners();
    return !playList.isValue(item.id);
  }
}
