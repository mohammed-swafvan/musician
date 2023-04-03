
import 'package:flutter/material.dart';
import 'package:musician/presentation/now_playing/now_playing.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ArtWorkWidget extends StatelessWidget {
  const ArtWorkWidget({
    Key? key,
    required this.widget,
    required this.currentIndex,
  }) : super(key: key);

  final NowPlayingScreen widget;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return QueryArtworkWidget(
        nullArtworkWidget: Container(
            height: 250,
            width: 250,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 80, 20, 91), borderRadius: BorderRadius.circular(50)),
            child: Icon(
              Icons.music_note_rounded,
              size: 150,
              color: Colors.purple[100],
            )),
        keepOldArtwork: true,
        artworkBorder: BorderRadius.circular(50),
        artworkHeight: 250,
        artworkWidth: 250,
        id: widget.songModelList[currentIndex].id ,
        type: ArtworkType.AUDIO);
  }
}
