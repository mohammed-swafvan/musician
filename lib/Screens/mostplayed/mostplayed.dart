import 'package:flutter/material.dart';
import 'package:musician/DB/functions/mostPlayedDb.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../AllMusic/ListTiles.dart';

class MostPlayed extends StatefulWidget {
  const MostPlayed({super.key});

  @override
  State<MostPlayed> createState() => _MostPlayedState();
}

class _MostPlayedState extends State<MostPlayed> {
  final OnAudioQuery audioQuery = OnAudioQuery();
  static List<SongModel> mostPlayedSongList = [];

  @override
  void initState() {
    getMostPlayedSongs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MostPlayedDb.getMostPlayedSongs(),
      builder: (context, item) {
        return ValueListenableBuilder(
          valueListenable: MostPlayedDb.mostPlayedNotifier,
          builder: (BuildContext context, List<SongModel> mostPlayed, child) {
            if (mostPlayed.isEmpty) {
              return const Center(
                child: Text(
                  'No Most Played Songs',
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
                ),
              );
            } else {
              final temp = mostPlayed.reversed.toList();
              mostPlayedSongList = temp.toSet().toList();
              return FutureBuilder<List<SongModel>>(
                future: audioQuery.querySongs(
                    sortType: null, orderType: OrderType.ASC_OR_SMALLER, uriType: UriType.EXTERNAL, ignoreCase: true),
                builder: (context, item) {
                  if (item.data == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (item.data!.isEmpty) {
                    return const Center(
                      child: Text(
                        'No Recently Played Songs',
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    );
                  }
                  return ListTileWidget(
                    songModel: mostPlayedSongList,
                    recentlyPlayedSongsLength: mostPlayedSongList.length > 10 ? 10 : mostPlayedSongList.length,
                    isMostlyPlayed: true,
                  );
                },
              );
            }
          },
        );
      },
    );
  }

  Future<void> getMostPlayedSongs() async {
    await MostPlayedDb.getMostPlayedSongs();
  }
}
