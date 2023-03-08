import 'package:flutter/material.dart';
import 'package:musician/Screens/NowPlaying/NowPlaying.dart';
import 'package:musician/controller/GetAllSongsController.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';
import '../../Themes/Colors.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({super.key});

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> with TickerProviderStateMixin {
  bool firstSong = false;
  bool isPlaying = false;
  late AnimationController circleAnimation;

  @override
  void initState() {
    GetAllSongController.audioPlayer.currentIndexStream.listen((index) {
      if (index != null && mounted) {
        setState(() {
          index == 0 ? firstSong = true : firstSong = false;
        });
      }
    });

    circleAnimation = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenWith = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => NowPlayingScreen(songModelList: GetAllSongController.playingsong)));
      },
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          height: screenHeight * 0.1,
          width: screenWith,
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: componentsColor,
                    border: const Border(top: BorderSide(color: Color.fromARGB(255, 107, 33, 146), width: 3))),
                width: screenWith,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.only(left: 90),
                  child: Row(
                    children: [
                      SizedBox(
                        width: screenHeight * 0.2,
                        height: double.infinity,
                        child: Center(
                          child: StreamBuilder<bool>(
                            stream: GetAllSongController.audioPlayer.playingStream,
                            builder: (context, snapshot) {
                              bool? playingStage = snapshot.data;
                              if (playingStage != null && playingStage) {
                                return TextScroll(
                                  GetAllSongController
                                      .playingsong[GetAllSongController.audioPlayer.currentIndex!].displayNameWOExt,
                                  mode: TextScrollMode.endless,
                                  style: TextStyle(color: Colors.deepPurple[100], fontWeight: FontWeight.w500),
                                );
                              } else {
                                return Text(
                                  GetAllSongController
                                      .playingsong[GetAllSongController.audioPlayer.currentIndex!].displayNameWOExt,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.deepPurple[100], fontWeight: FontWeight.w500),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                      Center(
                        child: Row(
                          children: [
                            firstSong
                                ? const IconButton(
                                    onPressed: null,
                                    icon: Icon(
                                      Icons.skip_previous_rounded,
                                      color: Colors.white70,
                                      size: 35,
                                    ),
                                  )
                                : IconButton(
                                    onPressed: () async {
                                      if (GetAllSongController.audioPlayer.hasPrevious) {
                                        await GetAllSongController.audioPlayer.seekToPrevious();
                                        await GetAllSongController.audioPlayer.play();
                                      } else {
                                        GetAllSongController.audioPlayer.play();
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.skip_previous_rounded,
                                      color: Colors.white70,
                                      size: 35,
                                    ),
                                  ),
                            IconButton(
                                onPressed: () async {
                                  setState(() {
                                    isPlaying = !isPlaying;
                                  });
                                  if (GetAllSongController.audioPlayer.playing) {
                                    await GetAllSongController.audioPlayer.pause();
                                    setState(() {});
                                  } else {
                                    await GetAllSongController.audioPlayer.play();
                                  }
                                },
                                icon: StreamBuilder<bool>(
                                  stream: GetAllSongController.audioPlayer.playingStream,
                                  builder: (context, snapshot) {
                                    bool? playingSatge = snapshot.data;
                                    if (playingSatge != null && playingSatge) {
                                      return const Icon(
                                        Icons.pause_rounded,
                                        color: Colors.white70,
                                        size: 35,
                                      );
                                    } else {
                                      return const Icon(
                                        Icons.play_arrow_rounded,
                                        color: Colors.white70,
                                        size: 35,
                                      );
                                    }
                                  },
                                )),
                            IconButton(
                              onPressed: () async {
                                if (GetAllSongController.audioPlayer.hasNext) {
                                  await GetAllSongController.audioPlayer.seekToNext();
                                  await GetAllSongController.audioPlayer.play();
                                } else {
                                  await GetAllSongController.audioPlayer.play();
                                }
                              },
                              icon: const Icon(
                                Icons.skip_next_rounded,
                                color: Colors.white70,
                                size: 35,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5, left: 15),
                child: CircleAvatar(
                    radius: 32,
                    backgroundColor: const Color.fromARGB(255, 106, 32, 120),
                    child: StreamBuilder<bool>(
                        stream: GetAllSongController.audioPlayer.playingStream,
                        builder: (context, snapshot) {
                          bool? playingStage = snapshot.data;
                          if (playingStage != null && playingStage) {
                            return RotationTransition(
                              turns: Tween(begin: 0.0, end: 1.0).animate(circleAnimation),
                              child: CircleAvatar(
                                  backgroundColor: componentsColor,
                                  radius: 25,
                                  child: QueryArtworkWidget(
                                    id: GetAllSongController.playingsong[GetAllSongController.audioPlayer.currentIndex!].id,
                                    type: ArtworkType.AUDIO,
                                    keepOldArtwork: true,
                                    artworkFit: BoxFit.cover,
                                    nullArtworkWidget: Icon(
                                      Icons.music_note,
                                      size: 30,
                                      color: Colors.deepPurple[100],
                                    ),
                                  )),
                            );
                          } else {
                            return CircleAvatar(
                                backgroundColor: componentsColor,
                                radius: 25,
                                child: QueryArtworkWidget(
                                  id: GetAllSongController.playingsong[GetAllSongController.audioPlayer.currentIndex!].id,
                                  type: ArtworkType.AUDIO,
                                  keepOldArtwork: true,
                                  artworkFit: BoxFit.cover,
                                  nullArtworkWidget: Icon(
                                    Icons.music_note,
                                    size: 30,
                                    color: Colors.deepPurple[100],
                                  ),
                                ));
                          }
                        })),
              )
            ],
          ),
        ),
      ),
    );
  }
}
