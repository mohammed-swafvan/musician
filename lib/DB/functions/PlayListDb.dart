import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musician/DB/Models/Song_model.dart';
import 'package:musician/DB/functions/FavDbFunctions.dart';
import 'package:musician/Screens/Splash.dart';

class PlayListDb extends ChangeNotifier {
  static ValueNotifier<List<SongsDataBase>> playListNotifier = ValueNotifier([]);
  static final playListDb = Hive.box<SongsDataBase>('PlayListDb');

  static Future<void> addPlayList(SongsDataBase value) async {
    final playlistDb = Hive.box<SongsDataBase>('PlayListDb');
    await playlistDb.add(value);
    playListNotifier.value.add(value);
  }

  static Future<void> getAllPlaylist() async {
    final playlistDb = Hive.box<SongsDataBase>('PlayListDb');
    playListNotifier.value.clear();
    playListNotifier.value.addAll(playlistDb.values);
    playListNotifier.notifyListeners();
  }

  static Future<void> deletePlaylist(int index) async {
    final playlistDb = Hive.box<SongsDataBase>('PlayListDb');
    await playlistDb.deleteAt(index);
    getAllPlaylist();
  }

  static void editPlaylist(int index, SongsDataBase value) {
    final playlistDb = Hive.box<SongsDataBase>('PlayListDb');
    playlistDb.putAt(index, value);
    getAllPlaylist();
  }

  static Future<void> resetApp(BuildContext context) async {
    final playListDb = Hive.box<SongsDataBase>('PlayListDb');
    final recentlyplayDb = await Hive.openBox('RecentlyPlay');
    final musicDb = Hive.box<int>('FavDb');
    final mostPlayedDb = await Hive.openBox('MostlyPlayed');

    await playListDb.clear();
    await recentlyplayDb.clear();
    await musicDb.clear();
    await mostPlayedDb.clear();

    FavDbFun.favSongsNotifier.value.clear();
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SplashScreen()));
  }
}
