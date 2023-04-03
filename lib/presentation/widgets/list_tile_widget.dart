import 'package:flutter/material.dart';
import 'package:musician/controller/Provider/favorite/favorite_provider.dart';
import 'package:musician/controller/Provider/mostly_played/mostly_played_provider.dart';
import 'package:musician/controller/Provider/recenly_played/recenetly_played_provider.dart';
import 'package:musician/controller/core/themes/usually_colors.dart';
import 'package:musician/presentation/now_playing/now_playing.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import '../../controller/Provider/song_model_provider.dart';
import '../../controller/core/components/all_music_more_dialoge.dart';
import '../../controller/get_all_music_controller.dart';

// ignore: must_be_immutable
class ListTileWidget extends StatelessWidget {
  ListTileWidget({
    super.key,
    required this.songModel,
    this.recentlyPlayedSongsLength,
    this.isRecentlyPlayed = false,
    this.isMostlyPlayed = false,
  });

  final List<SongModel> songModel;
  final dynamic recentlyPlayedSongsLength;
  final bool isRecentlyPlayed;
  final bool isMostlyPlayed;

  List<SongModel> allSongs = [];

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: ((context, index) {
        allSongs.addAll(songModel);
        return ListTile(
          style: ListTileStyle.drawer,
          minVerticalPadding: 20,
          leading: QueryArtworkWidget(
              nullArtworkWidget: Container(
                  height: screenHeight * 0.09,
                  width: screenWidth * 0.14,
                  decoration:
                      BoxDecoration(color: const Color.fromARGB(255, 80, 20, 91), borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    Icons.music_note_rounded,
                    size: 30,
                    color: Colors.purple[100],
                  )),
              artworkHeight: screenHeight * 0.09,
              artworkWidth: screenWidth * 0.14,
              artworkBorder: BorderRadius.circular(10),
              id: songModel[index].id,
              type: ArtworkType.AUDIO),
          title: Text(
            songModel[index].displayNameWOExt,
            style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.white, overflow: TextOverflow.ellipsis),
          ),
          subtitle: Text(
            '${songModel[index].artist == '<unknown>' ? 'unknown Artist' : songModel[index].artist}',
            style: const TextStyle(
                fontWeight: FontWeight.w300, color: Colors.white60, overflow: TextOverflow.ellipsis, fontSize: 12),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                        backgroundColor: componentsColor,
                        context: context,
                        builder: (context) {
                          return FractionallySizedBox(
                            heightFactor: 0.5,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                children: [
                                  Consumer<FavoriteProvider>(
                                    builder: (context, value, child) {
                                      return ListTile(
                                            leading: value.isFav(songModel[index])
                                                ? Icon(
                                                    Icons.favorite,
                                                    color: Colors.deepPurple[100],
                                                    size: 30,
                                                  )
                                                : Icon(
                                                    Icons.heart_broken_outlined,
                                                    color: Colors.deepPurple[50],
                                                    size: 30,
                                                  ),
                                            title: value.isFav(songModel[index])
                                                ? Text(
                                                    'Remove from favourites',
                                                    style: TextStyle(
                                                        color: Colors.deepPurple[50], fontSize: 20, fontWeight: FontWeight.w500),
                                                  )
                                                : Text(
                                                    'Add to favourites',
                                                    style: TextStyle(
                                                        color: Colors.deepPurple[50], fontSize: 20, fontWeight: FontWeight.w500),
                                                  ),
                                            onTap: () {
                                              Navigator.pop(context);
                                              if (value.isFav(songModel[index])) {
                                                value.deleteSong(songModel[index].id);
                                                final removeFromFav = SnackBar(
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                  behavior: SnackBarBehavior.floating,
                                                  backgroundColor: componentsColor,
                                                  content: Text(
                                                    'Song Removed From Favourites',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(color: Colors.deepPurple[50]),
                                                  ),
                                                  duration: const Duration(seconds: 1),
                                                );
                                                ScaffoldMessenger.of(context).showSnackBar(removeFromFav);
                                              } else {
                                                value.addSongs(songModel[index]);
                                                final addedToFav = SnackBar(
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                  behavior: SnackBarBehavior.floating,
                                                  backgroundColor: componentsColor,
                                                  content: Text(
                                                    'Song Added To Favourite',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(color: Colors.deepPurple[50]),
                                                  ),
                                                  duration: const Duration(seconds: 1),
                                                );
                                                ScaffoldMessenger.of(context).showSnackBar(addedToFav);
                                              }
                                            },
                                          );
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.playlist_add,
                                      color: Colors.deepPurple[50],
                                      size: 30,
                                    ),
                                    title: Text(
                                      'Add to PlayList',
                                      style: TextStyle(color: Colors.deepPurple[50], fontSize: 20, fontWeight: FontWeight.w500),
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);
                                      showPlayListDialog(context, songModel[index]);
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.error_outline,
                                      color: Colors.deepPurple[50],
                                      size: 30,
                                    ),
                                    title: Text(
                                      'Song Info',
                                      style: TextStyle(color: Colors.deepPurple[50], fontSize: 20, fontWeight: FontWeight.w500),
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);
                                      showSongsDetails(context, songModel[index]);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  icon: const Icon(
                    Icons.more_horiz,
                    color: Colors.white70,
                    size: 32,
                  ))
            ],
          ),
          onTap: () {
            GetAllSongController.audioPlayer.setAudioSource(
              GetAllSongController.createSongList(songModel),
              initialIndex: index,
            );
            Provider.of<MostlyPlayedProvider>(context, listen: false).addSongsToMostly(songModel[index].id);
            Provider.of<RecentlyPlayedProvider>(context, listen: false).addSongToRecently(songModel[index].id);
            context.read<SongModelProvider>().setId(songModel[index].id);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => NowPlayingScreen(
                          songModelList: songModel,
                          count: songModel.length,
                        ))));
          },
        );
      }),
      itemCount: isRecentlyPlayed || isMostlyPlayed ? recentlyPlayedSongsLength : songModel.length,
    );
  }
}
