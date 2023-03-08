import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musician/DB/Models/Song_model.dart';
import 'package:musician/Themes/Colors.dart';

import '../../PlayList/PlatListsScreen.dart';

class NoPlayList extends StatelessWidget {
  const NoPlayList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<SongsDataBase>('PlayListdb').listenable(),
      builder: (context, Box<SongsDataBase> value, child) {
        final playLists = Hive.box<SongsDataBase>('PlayListdb');
        return SizedBox(
          height: 250,
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(
                height: 50,
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    'Musician',
                    style: TextStyle(
                      shadows: [Shadow(offset: Offset(4.0, 4.0), blurRadius: 3.0, color: Colors.white10)],
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 38,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const PlayListsScreen()));
                  },
                  child: Container(
                    decoration: BoxDecoration(color: componentsColor.withOpacity(0.6), borderRadius: BorderRadius.circular(20)),
                    height: 190,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          playLists.isEmpty ? Icons.playlist_add : Icons.library_music,
                          size: 55,
                          color: Colors.deepPurple[100],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          playLists.isEmpty ? 'Create Playlist' : 'Your Playlists',
                          style: TextStyle(fontSize: 20, color: Colors.deepPurple[100], fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
