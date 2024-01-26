import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musician/controller/Provider/now_playing/play_controls_provider.dart';
import 'package:musician/controller/get_all_music_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Playcontroller extends StatelessWidget {
  Playcontroller({
    super.key,
    required this.count,
    required this.firstSong,
    required this.lastSong,
    required this.allSongs,
  });
  final int count;
  final bool firstSong;
  final bool lastSong;
  final SongModel allSongs;

  bool isShuffling = false;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<PlayControlsProvider>(context, listen: false).songIsPlaying = true;
    });
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Consumer<PlayControlsProvider>(builder: (context, value, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  isShuffling == false ? value.turnOnshuffleMode() : value.turnOffshuffleMode();
                },
                icon: StreamBuilder<bool>(
                  stream: GetAllSongController.audioPlayer.shuffleModeEnabledStream,
                  builder: (context, snapshot) {
                    isShuffling = snapshot.data ?? false;
                    if (isShuffling) {
                      return const Icon(
                        Icons.shuffle,
                        size: 26,
                        color: Colors.white70,
                      );
                    } else {
                      return const Icon(
                        Icons.shuffle,
                        size: 26,
                        color: Colors.white38,
                      );
                    }
                  },
                )),
            SizedBox(
              height: screenHeight * 0.1,
              width: screenWidth * 0.19,
              child: firstSong
                  ? IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.skip_previous_rounded,
                        size: 48,
                        color: Colors.white70,
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        if (GetAllSongController.audioPlayer.hasPrevious) {
                          GetAllSongController.audioPlayer.seekToPrevious();
                        }
                      },
                      icon: const Icon(
                        Icons.skip_previous_rounded,
                        size: 48,
                        color: Colors.white70,
                      ),
                    ),
            ),
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.white),
              child: IconButton(
                onPressed: () {
                  if (GetAllSongController.audioPlayer.playing) {
                    value.songPause();
                  } else {
                    value.songPlay();
                  }
                  value.playPause();
                },
                icon: Icon(
                  value.isPlaying == true ? Icons.pause_rounded : Icons.play_arrow_rounded,
                  size: 45,
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.1,
              width: screenWidth * 0.19,
              child: lastSong
                  ? const IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.skip_next_rounded,
                        size: 48,
                        color: Colors.white70,
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        if (GetAllSongController.audioPlayer.hasNext) {
                          GetAllSongController.audioPlayer.seekToNext();
                        }
                      },
                      icon: const Icon(
                        Icons.skip_next_rounded,
                        size: 48,
                        color: Colors.white70,
                      ),
                    ),
            ),
            IconButton(
              onPressed: () {
                GetAllSongController.audioPlayer.loopMode == LoopMode.one
                    ? GetAllSongController.audioPlayer.setLoopMode(LoopMode.all)
                    : GetAllSongController.audioPlayer.setLoopMode(LoopMode.one);
              },
              icon: StreamBuilder<LoopMode>(
                stream: GetAllSongController.audioPlayer.loopModeStream,
                builder: (context, snapshot) {
                  final loopMode = snapshot.data;
                  if (LoopMode.one == loopMode) {
                    return const Icon(
                      Icons.repeat_one,
                      size: 26,
                      color: Colors.white70,
                    );
                  } else {
                    return const Icon(
                      Icons.repeat,
                      size: 26,
                      color: Colors.white38,
                    );
                  }
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
