import 'package:flutter/material.dart';
import 'package:musician/DB/functions/FavDbFunctions.dart';
import 'package:musician/DB/functions/RecentlyDb.dart';
import 'package:musician/DB/functions/mostPlayedDb.dart';
import 'package:musician/Screens/NowPlaying/NowPlaying.dart';
import 'package:musician/Themes/Colors.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import '../../Provider/SongModelProvider.dart';
import '../../components/AllMusicMoreDialogu.dart';
import '../../controller/GetAllSongsController.dart';

class ListTileWidget extends StatefulWidget {
  const ListTileWidget(
      {super.key,
      required this.songModel,
      this.recentlyPlayedSongsLength,
      this.isRecentlyPlayed = false,
      this.isMostlyPlayed = false});

  final List<SongModel> songModel;
  final dynamic recentlyPlayedSongsLength;
  final bool isRecentlyPlayed;
  final bool isMostlyPlayed;

  @override
  State<ListTileWidget> createState() => _ListTileWidgetState();
}

class _ListTileWidgetState extends State<ListTileWidget> {
  List<SongModel> allSongs = [];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: ((context, index) {
        allSongs.addAll(widget.songModel);
        return ListTile(
          style: ListTileStyle.drawer,
          minVerticalPadding: 20,
          leading: QueryArtworkWidget(
              nullArtworkWidget: Container(
                  height: 55,
                  width: 55,
                  decoration:
                      BoxDecoration(color: const Color.fromARGB(255, 80, 20, 91), borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    Icons.music_note_rounded,
                    size: 30,
                    color: Colors.purple[100],
                  )),
              artworkHeight: 55,
              artworkWidth: 55,
              artworkBorder: BorderRadius.circular(10),
              id: widget.songModel[index].id,
              type: ArtworkType.AUDIO),
          title: Text(
            widget.songModel[index].displayNameWOExt,
            style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.white, overflow: TextOverflow.ellipsis),
          ),
          subtitle: Text(
            '${widget.songModel[index].artist == '<unknown>' ? 'unknown Artist' : widget.songModel[index].artist}',
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
                                  ValueListenableBuilder(
                                    valueListenable: FavDbFun.favSongsNotifier,
                                    builder: (context, List<SongModel> favData, child) {
                                      return ValueListenableBuilder(
                                        valueListenable: FavDbFun.favSongsNotifier,
                                        builder: (context, List<SongModel> data, child) {
                                          return ListTile(
                                            leading: FavDbFun.isFav(widget.songModel[index])
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
                                            title: FavDbFun.isFav(widget.songModel[index])
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
                                              if (FavDbFun.isFav(widget.songModel[index])) {
                                                FavDbFun.deleteSong(widget.songModel[index].id);
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
                                                FavDbFun.addSongs(widget.songModel[index]);
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
                                              FavDbFun.favSongsNotifier.notifyListeners();
                                            },
                                          );
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
                                      showPlayListDialog(context, widget.songModel[index]);
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
                                      showSongsDetails(context, widget.songModel[index]);
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
              GetAllSongController.createSongList(widget.songModel),
              initialIndex: index,
            );
            MostPlayedDb.addSongsToMostly(widget.songModel[index].id);
            RecentlyDb.addSongToRecently(widget.songModel[index].id);
            context.read<SongModelProvider>().setId(widget.songModel[index].id);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => NowPlayingScreen(
                          songModelList: widget.songModel,
                          count: widget.songModel.length,
                        ))));
          },
        );
      }),
      itemCount: widget.isRecentlyPlayed || widget.isMostlyPlayed ? widget.recentlyPlayedSongsLength : widget.songModel.length,
    );
  }
}
