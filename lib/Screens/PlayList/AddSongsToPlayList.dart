
import 'package:flutter/material.dart';
import 'package:musician/DB/functions/PlayListDb.dart';
import 'package:musician/controller/GetAllSongsController.dart';
import 'package:musician/Themes/BackDropWidget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../DB/Models/Song_model.dart';
import '../../Themes/Colors.dart';
import '../../Themes/BackGroundDesign.dart';

class AddSongsToPlayList extends StatefulWidget {
  const AddSongsToPlayList({super.key, required this.playList});

  final SongsDataBase playList;

  @override
  State<AddSongsToPlayList> createState() => _AddSongsToPlayListState();
}

class _AddSongsToPlayListState extends State<AddSongsToPlayList> {
  bool isPlaying = true;
  final OnAudioQuery audioQuery = OnAudioQuery();
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: bgColor,
        body: FutureBuilder<List<SongModel>>(
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
                child: Text('No Songs Available'),
              );
            }
            return Stack(
              children: [
                const Blue(),
                const Purple(),
                const BackdropWidget(),
                ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: ListTile(
                        leading: IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 28,
                            color: Colors.white38,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        title: const Text(
                          'Add Songs',
                          style: TextStyle(
                            shadows: [Shadow(offset: Offset(4.0, 4.0), blurRadius: 3.0, color: Colors.white10)],
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        controller: ScrollController(keepScrollOffset: true),
                        itemCount: item.data!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: QueryArtworkWidget(
                                nullArtworkWidget: Container(
                                    height: screenHeight * 0.1,
                                    width: screenWidth * 0.14,
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(255, 80, 20, 91), borderRadius: BorderRadius.circular(10)),
                                    child: Icon(
                                      Icons.music_note_rounded,
                                      size: 30,
                                      color: Colors.purple[100],
                                    )),
                                artworkHeight: screenHeight * 0.1,
                                artworkWidth: screenWidth * 0.14,
                                artworkBorder: BorderRadius.circular(10),
                                id: item.data![index].id,
                                type: ArtworkType.AUDIO),
                            title: Text(
                              item.data![index].displayNameWOExt,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, color: Colors.white, overflow: TextOverflow.ellipsis),
                            ),
                            subtitle: Text(
                              '${item.data![index].artist == '<unknown>' ? 'unknown Artist' : item.data![index].artist}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white60,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 12),
                            ),
                            trailing: !widget.playList.isValue(item.data![index].id)
                                ? IconButton(
                                    onPressed: () {
                                      GetAllSongController.songscopy = item.data!;
                                      setState(() {
                                        songsToPlayList(
                                          item.data![index],
                                        );
                                        // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
                                        PlayListDb.playListNotifier.notifyListeners();
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.add,
                                      color: Colors.white70,
                                      size: 26,
                                    ))
                                : IconButton(
                                    onPressed: () {
                                      setState(() {
                                        songDeletedFromPlaylist(item.data![index]);
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.remove,
                                      color: Colors.white70,
                                      size: 26,
                                    )),
                            onTap: () {},
                          );
                        })
                  ],
                ),
              ],
            );
          },
        ));
  }

  void songsToPlayList(SongModel song) {
    widget.playList.add(song.id);
    final addedToPlayList = SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      behavior: SnackBarBehavior.floating,
      backgroundColor: componentsColor,
      content: Text(
        'Song Added',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.deepPurple[50]),
      ),
      duration: const Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(addedToPlayList);
  }

  void songDeletedFromPlaylist(SongModel song) {
    widget.playList.deleteData(song.id);
    final removeFromPlaylist = SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      behavior: SnackBarBehavior.floating,
      backgroundColor: componentsColor,
      content: Text(
        'Song Removed',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.deepPurple[50]),
      ),
      duration: const Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(removeFromPlaylist);
  }
}
