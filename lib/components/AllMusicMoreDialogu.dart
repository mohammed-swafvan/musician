import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';

import '../DB/Models/Song_model.dart';
import '../Screens/PlayList/PlatListsScreen.dart';
import '../Themes/Colors.dart';

showPlayListDialog(BuildContext context, SongModel songModel) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.deepPurple[50],
        title: Text(
          'Choose Playlist',
          style: TextStyle(color: componentsColor, fontWeight: FontWeight.w500, fontSize: 18),
        ),
        content: SizedBox(
          height: 200,
          width: double.maxFinite,
          child: ValueListenableBuilder(
            valueListenable: Hive.box<SongsDataBase>('PlayListDb').listenable(),
            builder: (context, Box<SongsDataBase> musicList, child) {
              return Hive.box<SongsDataBase>('PlayListdb').isEmpty
                  ? const Center(
                      child: Text(
                        'No Playlists',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : ListView.builder(
                      itemCount: musicList.length,
                      itemBuilder: (context, index) {
                        final data = musicList.values.toList()[index];
                        return Card(
                          color: Colors.deepPurple[100],
                          shadowColor: Colors.deepPurple[500],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), side: BorderSide(color: componentsColor)),
                          child: ListTile(
                            title: Text(
                              data.name,
                              style: TextStyle(color: componentsColor, fontWeight: FontWeight.w500),
                            ),
                            trailing: Icon(
                              Icons.playlist_add,
                              color: componentsColor,
                            ),
                            onTap: () {
                              songAddingToPlayList(context, songModel, data, data.name);
                            },
                          ),
                        );
                      });
            },
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                nameController.clear();
                Navigator.pop(context);
                createNewPlayList(context, formKey);
              },
              child: Text(
                'New Playlist',
                style: TextStyle(color: componentsColor, fontWeight: FontWeight.w500),
              )),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: componentsColor, fontWeight: FontWeight.w500),
              ))
        ],
      );
    },
  );
}

void songAddingToPlayList(BuildContext context, SongModel data, SongsDataBase datas, String name) {
  if (!datas.isValue(data.id)) {
    datas.add(data.id);
    final songAddedSanckBar = SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 1),
        backgroundColor: componentsColor,
        behavior: SnackBarBehavior.floating,
        content: Text(
          'Song added to $name',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.deepPurple[50]),
        ));
    ScaffoldMessenger.of(context).showSnackBar(songAddedSanckBar);
    Navigator.pop(context);
  } else {
    final songAlreadyExist = SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 1),
        backgroundColor: componentsColor,
        behavior: SnackBarBehavior.floating,
        content: Text(
          'Song already exist in $name',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.deepPurple[50]),
        ));
    ScaffoldMessenger.of(context).showSnackBar(songAlreadyExist);
    Navigator.pop(context);
  }
}

showSongsDetails(BuildContext contextOne, SongModel songsDetails) {
  showDialog(
    context: contextOne,
    builder: (contextOne) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.deepPurple[50],
        title: Text(
          'Song Info',
          style: TextStyle(color: componentsColor, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        content: SizedBox(
          height: 270,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              QueryArtworkWidget(
                  nullArtworkWidget: Container(
                      height: 200,
                      width: 200,
                      decoration:
                          BoxDecoration(color: const Color.fromARGB(255, 80, 20, 91), borderRadius: BorderRadius.circular(50)),
                      child: Icon(
                        Icons.music_note_rounded,
                        size: 100,
                        color: Colors.purple[100],
                      )),
                  keepOldArtwork: true,
                  artworkBorder: BorderRadius.circular(50),
                  artworkHeight: 200,
                  artworkWidth: 200,
                  id: songsDetails.id,
                  type: ArtworkType.AUDIO),
              Row(
                children: [
                  SizedBox(
                    width: 60,
                    child: Text(
                      'Album : ',
                      style: TextStyle(color: componentsColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: 170,
                    child: TextScroll(
                      songsDetails.title,
                      style: TextStyle(color: Colors.deepPurple[500], fontWeight: FontWeight.w500),
                      mode: TextScrollMode.endless,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 60,
                    child: Text(
                      'Artist   : ',
                      style: TextStyle(color: componentsColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: 170,
                    child: TextScroll(
                      songsDetails.artist.toString() == "<unknown>" ? 'Unknown Artist' : songsDetails.artist.toString(),
                      style: TextStyle(color: Colors.deepPurple[500], fontWeight: FontWeight.w500),
                      mode: TextScrollMode.endless,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(contextOne);
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: componentsColor, fontWeight: FontWeight.w500),
              ))
        ],
      );
    },
  );
}
