import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musician/DB/Models/Song_model.dart';
import 'package:musician/Provider/SongModelProvider.dart';
import 'package:musician/Screens/NowPlaying/NowPlaying.dart';
import 'package:musician/Screens/PlayList/AddSongsToPlayList.dart';
import 'package:musician/Themes/Colors.dart';
import 'package:musician/controller/GetAllSongsController.dart';
import 'package:musician/Themes/BackDropWidget.dart';
import 'package:musician/Themes/BackGroundDesign.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class IndividualPlayList extends StatefulWidget {
  const IndividualPlayList({super.key, required this.playList, required this.indexes, required this.photo});

  final SongsDataBase playList;
  final int indexes;
  final String photo;

  @override
  State<IndividualPlayList> createState() => _IndividualPlayListState();
}

class _IndividualPlayListState extends State<IndividualPlayList> {
  @override
  Widget build(BuildContext context) {
    late List<SongModel> songsPlayList;
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return ValueListenableBuilder(
      valueListenable: Hive.box<SongsDataBase>('PlayListDb').listenable(),
      builder: (BuildContext context, Box<SongsDataBase> music, child) {
        songsPlayList = listOfPlayList(music.values.toList()[widget.indexes].songId);
        return Scaffold(
          backgroundColor: bgColor,
          body: Stack(
            children: [
              const Blue(),
              const Purple(),
              const BackdropWidget(),
              SizedBox(
                child: ListView(
                  children: [
                    Stack(children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        child: Image.asset(
                          widget.photo,
                          width: screenWidth,
                          height: screenHeight * 0.3,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: SizedBox(
                          height: screenHeight * 0.27,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ListTile(
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
                                trailing: CircleAvatar(
                                  backgroundColor: const Color.fromARGB(255, 40, 18, 140),
                                  radius: 22,
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => AddSongsToPlayList(playList: widget.playList)));
                                    },
                                    icon: const Icon(
                                      Icons.add,
                                      size: 28,
                                      color: Colors.white38,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 30.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 35,
                                      child: Text(
                                        widget.playList.name,
                                        style: const TextStyle(
                                          shadows: [Shadow(offset: Offset(4.0, 4.0), blurRadius: 3.0, color: Colors.white10)],
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                          fontSize: 38,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 33,
                                      child: Row(
                                        children: [
                                          const Text('Play List  ',
                                              style: TextStyle(
                                                color: Colors.white54,
                                                fontWeight: FontWeight.w500,
                                              )),
                                          const Text(
                                            "\u2022 ",
                                            style: TextStyle(fontSize: 30, color: Colors.white),
                                          ),
                                          Text("${songsPlayList.length} Songs  ",
                                              style: const TextStyle(
                                                color: Colors.white54,
                                                fontWeight: FontWeight.w400,
                                              )),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ]),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: SizedBox(
                        child: songsPlayList.isEmpty
                            ? SizedBox(
                                height: screenHeight * 0.65,
                                child: Center(
                                    child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddSongsToPlayList(
                                          playList: widget.playList,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add_circle_outline,
                                        color: Colors.deepPurple[50],
                                        size: 100,
                                      ),
                                      Text(
                                        'Add Songs',
                                        style:
                                            TextStyle(fontSize: 22, color: Colors.deepPurple[100], fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                )),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                controller: ScrollController(keepScrollOffset: true),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5),
                                    child: ListTile(
                                      leading: QueryArtworkWidget(
                                          nullArtworkWidget: Container(
                                              height: 60,
                                              width: 55,
                                              decoration: BoxDecoration(
                                                  color: const Color.fromARGB(255, 80, 20, 91),
                                                  borderRadius: BorderRadius.circular(10)),
                                              child: Icon(
                                                Icons.music_note_rounded,
                                                size: 30,
                                                color: Colors.purple[100],
                                              )),
                                          artworkHeight: 60,
                                          artworkWidth: 55,
                                          artworkBorder: BorderRadius.circular(10),
                                          id: songsPlayList[index].id,
                                          type: ArtworkType.AUDIO),
                                      title: Text(
                                        songsPlayList[index].displayNameWOExt,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500, color: Colors.white, overflow: TextOverflow.ellipsis),
                                      ),
                                      trailing: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                songDeleteFromPlaylist(songsPlayList[index], context);
                                              },
                                              icon: const Icon(
                                                Icons.remove,
                                                color: Colors.white70,
                                                size: 32,
                                              ))
                                        ],
                                      ),
                                      onTap: () {
                                        GetAllSongController.audioPlayer.setAudioSource(
                                            GetAllSongController.createSongList(songsPlayList),
                                            initialIndex: index);

                                        context.read<SongModelProvider>().setId(songsPlayList[index].id);

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => NowPlayingScreen(
                                                      songModelList: songsPlayList,
                                                      count: songsPlayList.length,
                                                    )));
                                      },
                                    ),
                                  );
                                },
                                itemCount: songsPlayList.length,
                              ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void songDeleteFromPlaylist(SongModel data, context) {
    widget.playList.deleteData(data.id);
    final removePlaylist = SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: componentsColor,
      content: const Text(
        'Song removed from Playlist',
        style: TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      ),
      duration: const Duration(milliseconds: 550),
    );
    ScaffoldMessenger.of(context).showSnackBar(removePlaylist);
  }

  List<SongModel> listOfPlayList(List<int> data) {
    List<SongModel> plsongs = [];
    for (int i = 0; i < GetAllSongController.songscopy.length; i++) {
      for (int j = 0; j < data.length; j++) {
        if (GetAllSongController.songscopy[i].id == data[j]) {
          plsongs.add(GetAllSongController.songscopy[i]);
        }
      }
    }
    return plsongs;
  }
}
