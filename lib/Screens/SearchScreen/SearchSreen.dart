import 'package:flutter/material.dart';
import 'package:musician/Screens/AllMusic/ListTiles.dart';
import 'package:musician/Screens/SearchScreen/SearchListTile.dart';
import 'package:musician/Themes/Colors.dart';
import 'package:musician/Themes/BackDropWidget.dart';
import 'package:musician/Themes/BackGroundDesign.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

List<SongModel> allSongs = [];
List<SongModel> foundedSongs = [];
final audioQuery = OnAudioQuery();

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    songsAreLoading();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          const Blue(),
          const Purple(),
          const BackdropWidget(),
          SafeArea(
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: ListView(
                shrinkWrap: true,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 26,
                          color: Colors.white38,
                        ),
                      ),
                      const Text('Search',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 38,
                              shadows: [Shadow(offset: Offset(4.0, 4.0), blurRadius: 3.0, color: Colors.white10)]))
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.deepPurple[50],
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)),
                          ),
                          height: 50,
                          width: 45,
                          child: const Padding(padding: EdgeInsets.only(left: 7.0), child: Icon(Icons.search)),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.deepPurple[50],
                              borderRadius:
                                  const BorderRadius.only(bottomRight: Radius.circular(30), topRight: Radius.circular(30))),
                          height: 50,
                          width: 300,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: TextField(
                              onChanged: (value) => updatedList(value),
                              textAlign: TextAlign.start,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                              decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  border: InputBorder.none,
                                  hintText: 'Songs',
                                  hintStyle: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w500)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SearchScreenListTile(songModel: foundedSongs),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void songsAreLoading() async {
    allSongs = await audioQuery.querySongs(
        sortType: null, orderType: OrderType.ASC_OR_SMALLER, uriType: UriType.EXTERNAL, ignoreCase: true);

    setState(() {
      foundedSongs = allSongs;
    });
  }

  void updatedList(String enteredText) async {
    List<SongModel> results = [];
    if (enteredText.isEmpty) {
      results = allSongs;
    } else {
      results = allSongs.where((element) => element.displayNameWOExt.toLowerCase().contains(enteredText.toLowerCase())).toList();
    }
    setState(() {
      foundedSongs = results;
    });
  }
}
