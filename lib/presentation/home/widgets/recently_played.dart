import 'package:flutter/material.dart';
import 'package:musician/controller/Provider/recenly_played/recenetly_played_provider.dart';
import 'package:musician/presentation/widgets/list_tile_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class RecentlyPlayed extends StatelessWidget {
  RecentlyPlayed({super.key});

  final OnAudioQuery audioQuery = OnAudioQuery();
  static List<SongModel> recentlyPlayedSongList = [];

  @override
  Widget build(BuildContext context) {
    final recentProvi = Provider.of<RecentlyPlayedProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      recentProvi.getRecentlyPlayedSongs();
    });
    return FutureBuilder(
      future: recentProvi.getRecentlyPlayedSongs(),
      builder: (context, item) {
        return Consumer<RecentlyPlayedProvider>(
          builder: (BuildContext context, value, child) {
            if (value.recentlyPlay.isEmpty) {
              return const Center(
                child: Text(
                  'No Recently Played Songs',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                ),
              );
            } else {
              final temp = value.recentlyPlay.reversed.toList();
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
                    return const Column(
                      children: [
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
}
