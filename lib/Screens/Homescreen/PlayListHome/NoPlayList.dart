import 'package:flutter/material.dart';
import 'package:musician/Themes/Colors.dart';

import '../../PlayList/PlatListsScreen.dart';

class NoPlayList extends StatelessWidget {
  const NoPlayList({super.key});

  @override
  Widget build(BuildContext context) {
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
                decoration: BoxDecoration(color: componentsColor.withOpacity(0.7), borderRadius: BorderRadius.circular(20)),
                height: 180,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.playlist_add,
                      size: 55,
                      color: Colors.deepPurple[100],
                    ),
                    Text(
                      'Create Playlist',
                      style: TextStyle(fontSize: 20, color: Colors.deepPurple[100]),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
