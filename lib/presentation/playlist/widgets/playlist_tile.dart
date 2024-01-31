import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musician/models/Song_model.dart';
import 'package:musician/controller/core/components/playlist_more.dart';
import 'indtividual_platlist.dart';

// ignore: must_be_immutable
class PlayListTile extends StatelessWidget {
  PlayListTile({super.key, required this.musicList});

  final Box<SongsDataBase> musicList;

  final TextEditingController playListNameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int imageChanger = 1;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: ((context, index) {
          final data = musicList.values.toList()[index];
          imageChanger = Random().nextInt(9) + 1;
          String image = 'Assets/Images/image-$imageChanger.jpeg';
          return ValueListenableBuilder(
            valueListenable: Hive.box<SongsDataBase>('PlayListDb').listenable(),
            builder: (BuildContext context, Box<SongsDataBase> musicList, child) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Container(
                  height: screenHeight * 0.11,
                  decoration:
                      BoxDecoration(color: Colors.deepPurple[50]!.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => IndividualPlayList(
                                  playList: data,
                                  indexes: index,
                                  photo: image,
                                )),
                          ),
                        );
                      },
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          image,
                          fit: BoxFit.cover,
                          height: screenHeight * 0.1,
                          width: screenWidth * 0.15,
                        ),
                      ),
                      title: Text(
                        data.name,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              playListMore(context, index, musicList, formKey, playListNameController, data);
                            },
                            icon: const Icon(Icons.more_horiz, color: Colors.white70, size: 32),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }),
        controller: ScrollController(keepScrollOffset: true),
        itemCount: musicList.length,
      ),
    );
  }
}
