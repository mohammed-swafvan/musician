import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../controller/GetAllSongsController.dart';

class Playcontroller extends StatefulWidget {
  const Playcontroller({
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

  @override
  State<Playcontroller> createState() => _PlaycontrollerState();
}

class _PlaycontrollerState extends State<Playcontroller> {
  bool isPlaying = true;
  bool isShuffling = false;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {
                setState(() {
                  isShuffling == false
                      ? GetAllSongController.audioPlayer.setShuffleModeEnabled(true)
                      : GetAllSongController.audioPlayer.setShuffleModeEnabled(false);
                });
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
            child: widget.firstSong
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
                setState(() {
                  if (mounted) {
                    setState(() {
                      if (GetAllSongController.audioPlayer.playing) {
                        GetAllSongController.audioPlayer.pause();
                      } else {
                        GetAllSongController.audioPlayer.play();
                      }
                      isPlaying = !isPlaying;
                    });
                  }
                });
              },
              icon: Icon(
                isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                size: 45,
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.1,
            width: screenWidth * 0.19,
            child: widget.lastSong
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
      ),
    );
  }
}
