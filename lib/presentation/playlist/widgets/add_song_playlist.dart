import 'package:flutter/material.dart';
import 'package:musician/models/Song_model.dart';
import 'package:musician/controller/Provider/playlists/playlist_provider.dart';
import 'package:musician/controller/core/themes/usually_colors.dart';
import 'package:musician/controller/core/themes/back_gound_design.dart';
import 'package:musician/controller/get_all_music_controller.dart';
import 'package:musician/presentation/widgets/back_drop_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddSongsToPlayList extends StatelessWidget {
  AddSongsToPlayList({super.key, required this.playList});

  final SongsDataBase playList;

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
                          return Consumer<PlayListProvider>(builder: (context, value, _) {
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
                              trailing: value.isContainInPlayList(playList, item.data![index])
                                  ? IconButton(
                                      icon: const Icon(
                                        Icons.add,
                                        color: Colors.white70,
                                        size: 26,
                                      ),
                                      onPressed: () {
                                        GetAllSongController.songscopy = item.data!;
                                        value.songsToPlayList(
                                          item.data![index],
                                          playList,
                                          context,
                                        );
                                      },
                                    )
                                  : IconButton(
                                      icon: const Icon(
                                        Icons.remove,
                                        color: Colors.white70,
                                        size: 26,
                                      ),
                                      onPressed: () {
                                        value.songDeletedFromPlaylist(item.data![index], playList, context);
                                      },
                                    ),
                              onTap: () {},
                            );
                          });
                        })
                  ],
                ),
              ],
            );
          },
        ));
  }
}
