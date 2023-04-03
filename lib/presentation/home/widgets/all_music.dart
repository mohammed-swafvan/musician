import 'package:flutter/material.dart';
import 'package:musician/controller/Provider/favorite/favorite_provider.dart';
import 'package:musician/presentation/widgets/list_tile_widget.dart';
import 'package:musician/controller/get_all_music_controller.dart';
import 'package:musician/controller/Provider/all_music/all_music_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

List<SongModel> startSong = [];

class AllMusic extends StatelessWidget {
  const AllMusic({super.key});

  @override
  Widget build(BuildContext context) {
    final allMusicProvider = Provider.of<AllMusicProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      allMusicProvider.requestStoragePermission();
    });
    final favProvider = Provider.of<FavoriteProvider>(context, listen: false);
    return FutureBuilder<List<SongModel>>(
        future: allMusicProvider.audioQuery.querySongs(
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
          if (!favProvider.isInitialized) {
            favProvider.initialize(item.data!);
          }
          GetAllSongController.songscopy = item.data!;
          return ListTileWidget(songModel: item.data!);
        }));
  }
}