import 'package:flutter/material.dart';
import 'package:musician/controller/Provider/mostly_played/mostly_played_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../../widgets/list_tile_widget.dart';

class MostPlayed extends StatelessWidget {
  MostPlayed({super.key});

  final OnAudioQuery audioQuery = OnAudioQuery();
  static List<SongModel> mostPlayedSongList = [];

  @override
  Widget build(BuildContext context) {
    final mostlyProvider = Provider.of<MostlyPlayedProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      mostlyProvider.getMostPlayedSongs();
    });
    return FutureBuilder(
      future: mostlyProvider.getMostPlayedSongs(),
      builder: (context, item) {
        return Consumer<MostlyPlayedProvider>(
          builder: (BuildContext context, value, child) {
            if (value.mostPlayedSongs.isEmpty) {
              return const Center(
                child: Text(
                  'No Most Played Songs',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                ),
              );
            } else {
              final temp = value.mostPlayedSongs.reversed.toList();
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
}
