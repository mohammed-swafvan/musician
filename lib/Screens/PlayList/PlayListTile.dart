import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musician/DB/Models/Song_model.dart';
import '../../components/PlaylistMore.dart';
import 'IndividualPlaylist.dart';

class PlayListTile extends StatefulWidget {
  const PlayListTile({super.key, required this.musicList});

  final Box<SongsDataBase> musicList;

  @override
  State<PlayListTile> createState() => _PlayListTileState();
}

class _PlayListTileState extends State<PlayListTile> {
  final TextEditingController playListNameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int imageChanger = 1;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: ((context, index) {
        final data = widget.musicList.values.toList()[index];
        imageChanger = Random().nextInt(9) + 1;
        String image = 'Assets/Images/image-$imageChanger.jpeg';
        return ValueListenableBuilder(
          valueListenable: Hive.box<SongsDataBase>('PlayListDb').listenable(),
          builder: (BuildContext context, Box<SongsDataBase> musicList, child) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10.0, left: 7, right: 7),
              child: Container(
                height: 80,
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
                                  ))));
                    },
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        image,
                        fit: BoxFit.cover,
                        height: 60,
                        width: 60,
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
      itemCount: widget.musicList.length,
    );
  }
}
