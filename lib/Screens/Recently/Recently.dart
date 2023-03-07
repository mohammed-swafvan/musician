import 'package:flutter/material.dart';
import 'package:musician/DB/functions/RecentlyDb.dart';
import 'package:musician/Screens/AllMusic/ListTiles.dart';
import 'package:on_audio_query/on_audio_query.dart';

class RecentlyPlayed extends StatefulWidget {
  const RecentlyPlayed({super.key});

  @override
  State<RecentlyPlayed> createState() => _RecentlyPlayedState();
}

class _RecentlyPlayedState extends State<RecentlyPlayed> {
  final OnAudioQuery audioQuery = OnAudioQuery();
  static List<SongModel> recentlyPlayedSongList = [];

  @override
  void initState() {
    getRecentlyPlayedSongs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: RecentlyDb.getRecentlyPlayedSongs(),
      builder: (context, item) {
        return ValueListenableBuilder(
          valueListenable: RecentlyDb.recentlyPlayedNotifier,
          builder: (BuildContext context, List<SongModel> recentlyPlayed, child) {
            if (recentlyPlayed.isEmpty) {
              return const Center(
                child: Text(
                  'No Recently Played Songs',
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
                ),
              );
            } else {
              final temp = recentlyPlayed.reversed.toList();
              recentlyPlayedSongList = temp.toSet().toList();
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
                    return Column(
                      children: const [
                        Text(
                          'No Recently Played Songs',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    );
                  }
                  return ListTileWidget(
                    songModel: recentlyPlayedSongList,
                    isRecentlyPlayed: true,
                    recentlyPlayedSongsLength: recentlyPlayedSongList.length > 10 ? 10 : recentlyPlayedSongList.length,
                  );
                },
              );
            }
          },
        );
      },
    );
  }

  Future<void> getRecentlyPlayedSongs() async {
    await RecentlyDb.getRecentlyPlayedSongs();
  }
}
