import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musician/models/Song_model.dart';
import 'package:musician/presentation/playlist/widgets/indtividual_platlist.dart';
import 'package:text_scroll/text_scroll.dart';

class PlalistListViews extends StatelessWidget {
  const PlalistListViews({super.key, required this.index, required this.data, required this.imageChanger});

  final SongsDataBase data;
  final int index;
  final int imageChanger;
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
          width: screenWidth * 0.3,
          child: ValueListenableBuilder(
            valueListenable: Hive.box<SongsDataBase>('PlayListDb').listenable(),
            builder: (context, Box<SongsDataBase> musicList, child) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => IndividualPlayList(
                                playList: data,
                                indexes: index,
                                photo: 'Assets/Images/image-$imageChanger.jpeg',
                              ))));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'Assets/Images/image-$imageChanger.jpeg',
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4, left: 7.0, right: 8),
                      child: TextScroll(
                        data.name,
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
