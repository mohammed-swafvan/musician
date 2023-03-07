import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musician/DB/functions/FavDbFunctions.dart';
import 'package:musician/Screens/AllMusic/ListTiles.dart';
import 'package:musician/controller/GetAllSongsController.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class ALlMusic extends StatefulWidget {
  const ALlMusic({super.key});

  @override
  State<ALlMusic> createState() => _ALlMusicState();
}

List<SongModel> startSong = [];

class _ALlMusicState extends State<ALlMusic> {
  final OnAudioQuery audioQuery = OnAudioQuery();
  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    requestStoragePermission();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SongModel>>(
        future: audioQuery.querySongs(
            sortType: null, orderType: OrderType.ASC_OR_SMALLER, uriType: UriType.EXTERNAL, ignoreCase: true),
        builder: ((context, item) {
          if (item.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (item.data!.isEmpty) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'No Songs Founded',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            );
          }
          startSong = item.data!;
          if (!FavDbFun.isInitialized) {
            FavDbFun.initialize(item.data!);
          }
          GetAllSongController.songscopy = item.data!;
          return ListTileWidget(songModel: item.data!);
        }));
  }

  void requestStoragePermission() async {
    bool permissionStatus = await audioQuery.permissionsStatus();
    if (!permissionStatus) {
      await audioQuery.permissionsRequest();
    }
    setState(() {});
    Permission.storage.request();
  }
}
