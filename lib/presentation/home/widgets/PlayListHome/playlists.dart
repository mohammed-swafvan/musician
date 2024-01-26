import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musician/models/Song_model.dart';
import 'package:musician/controller/core/themes/usually_colors.dart';
import 'package:musician/presentation/home/widgets/PlayListHome/empty_playlist.dart';
import 'package:musician/presentation/home/widgets/PlayListHome/playlist_view.dart';
import 'package:musician/presentation/playlist/screen_playlist.dart';

// ignore: must_be_immutable
class PlayList extends StatelessWidget {
  PlayList({super.key});

  int imageChanger = 1;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return ValueListenableBuilder(
      valueListenable: Hive.box<SongsDataBase>('PlayListdb').listenable(),
      builder: (context, Box<SongsDataBase> value, child) {
        return Hive.box<SongsDataBase>('PlayListDb').isEmpty || Hive.box<SongsDataBase>('PlayListDb').length < 4
            ? const NoPlayList()
            : SizedBox(
                height: screenHeight * 0.28,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
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
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 8),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: ((context, index) {
                            final data = value.values.toList()[index];
                            imageChanger = Random().nextInt(9) + 1;
                            return (index == 3)
                                ? Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => const PlayListsScreen()));
                                      },
                                      child: SizedBox(
                                          width: screenWidth * 0.3,
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context, MaterialPageRoute(builder: (context) => const PlayListsScreen()));
                                            },
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(20),
                                                      child: Container(
                                                        width: double.infinity,
                                                        decoration: BoxDecoration(color: componentsColor),
                                                        child: Center(
                                                          child: Icon(
                                                            Icons.menu,
                                                            size: 50,
                                                            color: Colors.deepPurple[100],
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.only(top: 4, left: 7),
                                                  child: Text(
                                                    'More',
                                                    style:
                                                        TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 17),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                    ),
                                  )
                                : PlalistListViews(
                                    index: index,
                                    data: data,
                                    imageChanger: imageChanger,
                                  );
                          }),
                          itemCount: (value.length >= 4) ? 4 : value.length,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                    )
                  ],
                ),
              );
      },
    );
  }
}
