import 'package:flutter/material.dart';
import 'package:musician/DB/functions/FavDbFunctions.dart';
import 'package:musician/Themes/Colors.dart';
import 'package:musician/components/bottomsheet.dart';
import 'package:musician/Screens/NowPlaying/playController.dart';
import 'package:musician/controller/GetAllSongsController.dart';
import 'package:musician/Themes/BackDropWidget.dart';
import 'package:musician/Themes/BackGroundDesign.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';
import '../../Themes/ArtWorkWidget.dart';

class NowPlayingScreen extends StatefulWidget {
  const NowPlayingScreen({super.key, required this.songModelList, this.count = 0});
  final List<SongModel> songModelList;

  final int count;

  @override
  State<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> {
  Duration durationObj = const Duration();
  Duration positionObject = const Duration();

  int currentIndex = 0;
  bool firstSong = false;
  bool lastSong = false;
  int large = 0;
  bool isLyrics = false;
  String resultText = 'Lyrics Not Founded';

  @override
  void initState() {
    GetAllSongController.audioPlayer.currentIndexStream.listen((index) {
      if (index != null) {
        GetAllSongController.currentIndexes = index;
        if (mounted) {
          setState(() {
            large = widget.count - 1;
            currentIndex = index;
            index == 0 ? firstSong = true : firstSong = false;
            index == large ? lastSong = true : lastSong = false;
          });
        }
      }
    });
    super.initState();
    playSongs();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          const Blue(),
          const Purple(),
          const BackdropWidget(),
          SizedBox(
            height: screenHeight,
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ListTile(
                      leading: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 28,
                          color: Colors.white38,
                        ),
                      ),
                      trailing: CircleAvatar(
                        backgroundColor: const Color.fromARGB(255, 40, 18, 140),
                        radius: 22,
                        child: IconButton(
                            onPressed: () {
                              nowPlayingBottumSheet(context, widget.songModelList[currentIndex]);
                            },
                            icon: const Icon(
                              Icons.more_horiz,
                              size: 28,
                              color: Colors.white38,
                            )),
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: screenHeight * 0.1,
                        ),
                        ArtWorkWidget(widget: widget, currentIndex: currentIndex),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 30),
                                child: TextScroll(
                                  widget.songModelList[currentIndex].displayNameWOExt,
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                  mode: TextScrollMode.endless,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${widget.songModelList[currentIndex].artist == '<unknown>' ? 'Unknown Artist' : widget.songModelList[currentIndex].artist}',
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: Colors.white60),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: screenHeight * 0.04,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    if (FavDbFun.isFav(widget.songModelList[currentIndex])) {
                                      FavDbFun.deleteSong(widget.songModelList[currentIndex].id);
                                      var remove = SnackBar(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        backgroundColor: componentsColor,
                                        behavior: SnackBarBehavior.floating,
                                        content: Text(
                                          'Song Removed From Favourites',
                                          style: TextStyle(color: Colors.deepPurple[50]),
                                          textAlign: TextAlign.center,
                                        ),
                                        duration: const Duration(seconds: 1),
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(remove);
                                    } else {
                                      FavDbFun.addSongs(widget.songModelList[currentIndex]);
                                      var addFav = SnackBar(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        backgroundColor: componentsColor,
                                        behavior: SnackBarBehavior.floating,
                                        content: Text(
                                          'Song Added To Favourites',
                                          style: TextStyle(color: Colors.deepPurple[50]),
                                          textAlign: TextAlign.center,
                                        ),
                                        duration: const Duration(seconds: 1),
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(addFav);
                                    }
                                    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                                    FavDbFun.favSongsNotifier.notifyListeners();
                                  },
                                  icon: FavDbFun.isFav(widget.songModelList[currentIndex])
                                      ? Icon(
                                          Icons.favorite,
                                          size: 28,
                                          color: Colors.deepPurple[50],
                                        )
                                      : Icon(
                                          Icons.heart_broken_outlined,
                                          size: 28,
                                          color: Colors.deepPurple[50],
                                        )),
                            ],
                          ),
                        ),
                        Slider(
                            activeColor: Colors.white,
                            inactiveColor: Colors.white10,
                            min: const Duration(microseconds: 0).inSeconds.toDouble(),
                            value: positionObject.inSeconds.toDouble(),
                            max: durationObj.inSeconds.toDouble(),
                            onChanged: ((value) {
                              setState(() {
                                changeToSeconds(value.toInt());
                                value = value;
                              });
                            })),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                positionObject.toString().split('.')[0],
                                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w300, color: Colors.white60),
                              ),
                              Text(
                                durationObj.toString().split('.')[0],
                                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w300, color: Colors.white60),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Playcontroller(
                        count: widget.count,
                        firstSong: firstSong,
                        lastSong: lastSong,
                        allSongs: widget.songModelList[currentIndex]),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void playSongs() {
    GetAllSongController.audioPlayer.play();
    GetAllSongController.audioPlayer.durationStream.listen((dur) {
      setState(() {
        durationObj = dur!;
      });
    });
    GetAllSongController.audioPlayer.positionStream.listen((pos) {
      setState(() {
        positionObject = pos;
      });
    });
  }

  void changeToSeconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    GetAllSongController.audioPlayer.seek(duration);
  }
}
