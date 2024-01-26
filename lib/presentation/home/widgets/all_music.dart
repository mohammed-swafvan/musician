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
    return StreamBuilder<List<SongModel>>(
        stream: allMusicProvider.mp3SongsStream,
        builder: ((context, item) {
          if (item.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (item.data == null) {
            return const Center(
              child: Text(
                  "Didn't get permission",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
            );
          }
          if (item.data!.isEmpty) {
            return const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'No Songs Founded',
                  style: TextStyle(color: Colors.white, fontSize: 16),
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
