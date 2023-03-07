import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musician/Screens/PlayList/IndividualPlaylist.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../../DB/Models/Song_model.dart';

class PlalistListViews extends StatefulWidget {
  const PlalistListViews({super.key, required this.index, required this.data, required this.imageChanger});

  final SongsDataBase data;
  final int index;
  final int imageChanger;
  @override
  State<PlalistListViews> createState() => _PlalistListViewsState();
}

class _PlalistListViewsState extends State<PlalistListViews> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
          width: 130,
          child: ValueListenableBuilder(
            valueListenable: Hive.box<SongsDataBase>('PlayListDb').listenable(),
            builder: (context, Box<SongsDataBase> musicList, child) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => IndividualPlayList(
                                playList: widget.data,
                                indexes: widget.index,
                                photo: 'Assets/Images/image-${widget.imageChanger}.jpeg',
                              ))));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'Assets/Images/image-${widget.imageChanger}.jpeg',
                        fit: BoxFit.cover,
                        height: 130,
                        width: double.infinity,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 7.0, right: 8),
                      child: TextScroll(
                        widget.data.name,
                        style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 17),
                        mode: TextScrollMode.endless,
                      ),
                    ),
                  ],
                ),
              );
            },
          )),
    );
  }
}
