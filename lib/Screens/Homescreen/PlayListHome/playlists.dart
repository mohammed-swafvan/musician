import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musician/DB/Models/Song_model.dart';
import 'package:musician/Screens/Homescreen/PlayListHome/NoPlayList.dart';
import 'package:musician/Screens/Homescreen/PlayListHome/plalistListViews.dart';
import 'package:musician/Screens/PlayList/PlatListsScreen.dart';
import 'package:musician/Themes/Colors.dart';

class PlayList extends StatefulWidget {
  const PlayList({super.key});

  @override
  State<PlayList> createState() => _PlayListState();
}

class _PlayListState extends State<PlayList> {
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
                height: screenHeight * 0.32,
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.06,
                      width: double.infinity,
                      child: const Padding(
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
                      padding: const EdgeInsets.only(top: 10.0, left: 8),
                      child: SizedBox(
                        width: double.infinity,
                        height: 180,
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
                                                ClipRRect(
                                                    borderRadius: BorderRadius.circular(20),
                                                    child: Container(
                                                      height: 130,
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
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.only(left: 7.0),
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
                ));
      },
    );
  }
}
