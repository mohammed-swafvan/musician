import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musician/models/Song_model.dart';

import 'package:musician/presentation/playlist/widgets/playlist_tile.dart';
import 'package:musician/presentation/widgets/back_drop_widget.dart';
import 'package:provider/provider.dart';
import 'package:musician/controller/Provider/playlists/playlist_provider.dart';
import 'package:musician/controller/core/themes/usually_colors.dart';
import 'package:musician/controller/core/themes/back_gound_design.dart';

class PlayListsScreen extends StatelessWidget {
  const PlayListsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final palylistProvider = Provider.of<PlayListProvider>(context, listen: false);
    var screenHeight = MediaQuery.of(context).size.height;
    return ValueListenableBuilder(
      valueListenable: Hive.box<SongsDataBase>('PlayListDb').listenable(),
      builder: (context, Box<SongsDataBase> musicList, child) {
        return Scaffold(
          backgroundColor: bgColor,
          body: Stack(
            children: [
              const Blue(),
              const Purple(),
              const BackdropWidget(),
              SizedBox(
                height: screenHeight,
                child: ListView(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          child: Image.asset(
                            'Assets/Images/lady with headset.jpeg',
                            width: double.infinity,
                            height: screenHeight * 0.3,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: SizedBox(
                            height: screenHeight * 0.27,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ListTile(
                                  leading: IconButton(
                                    icon: const Icon(
                                      Icons.arrow_back_ios_new_rounded,
                                      size: 28,
                                      color: Colors.white38,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  trailing: CircleAvatar(
                                    backgroundColor: const Color.fromARGB(255, 40, 18, 140),
                                    radius: 22,
                                    child: IconButton(
                                      onPressed: () {
                                        palylistProvider.nameController.clear();
                                        createNewPlayList(context, palylistProvider.formKey, palylistProvider.nameController);
                                      },
                                      icon: const Icon(
                                        Icons.add,
                                        size: 28,
                                        color: Colors.white38,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 30.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Play List',
                                        style: TextStyle(
                                          shadows: [Shadow(offset: Offset(4.0, 4.0), blurRadius: 3.0, color: Colors.white10)],
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                          fontSize: 38,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          createNewPlayList(context, palylistProvider.formKey, palylistProvider.nameController);
                                        },
                                        child: const Row(
                                          children: [
                                            Icon(
                                              Icons.playlist_add,
                                              size: 30,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              ' Add Play List',
                                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 20),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        child: Hive.box<SongsDataBase>('PlayListDb').isEmpty
                            ? SizedBox(
                                height: screenHeight * 0.65,
                                child: Center(
                                    child: InkWell(
                                  onTap: () {
                                    createNewPlayList(context, palylistProvider.formKey, palylistProvider.nameController);
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add_circle_outline,
                                        color: Colors.deepPurple[50],
                                        size: 60,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Create Play List',
                                        style:
                                            TextStyle(fontSize: 18, color: Colors.deepPurple[100], fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                )),
                              )
                            : PlayListTile(musicList: musicList))
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

Future createNewPlayList(BuildContext context, formKey, TextEditingController nameController) {
  return showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.deepPurple[50],
      children: [
        SimpleDialogOption(
          child: Text(
            'Create New Playlist',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: componentsColor),
          ),
        ),
        const SizedBox(height: 8),
        SimpleDialogOption(
          child: Form(
            key: formKey,
            child: TextFormField(
              textAlign: TextAlign.center,
              controller: nameController,
              maxLength: 14,
              decoration: InputDecoration(
                fillColor: Colors.white10.withOpacity(0.8),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.only(left: 15, top: 5),
              ),
              style: TextStyle(color: componentsColor, fontSize: 16, fontWeight: FontWeight.bold),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Playlist Name';
                } else {
                  return null;
                }
              },
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
                nameController.clear();
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: componentsColor, fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ),
            SimpleDialogOption(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  await saveButtonClicked(context, nameController);
                }
              },
              child: Text(
                'Create',
                style: TextStyle(color: componentsColor, fontWeight: FontWeight.w500, fontSize: 16),
              ),
            )
          ],
        )
      ],
    ),
  );
}

Future<void> saveButtonClicked(context, TextEditingController nameController) async {
  final playListProvider = Provider.of<PlayListProvider>(context, listen: false);
  final name = nameController.text.trim();
  final SongsDataBase newPlayList = SongsDataBase(name: name, songId: []);
  final List<String> playListName = playListProvider.playListDb.values.map((e) => e.name.trim()).toList();
  if (name.isEmpty) {
    return;
  } else if (playListName.contains(newPlayList.name)) {
    final playListExistSnackBar = SnackBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
        backgroundColor: componentsColor,
        content: Text(
          'Playlist Already Exist',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.deepPurple[50]),
        ));
    ScaffoldMessenger.of(context).showSnackBar(playListExistSnackBar);
    Navigator.of(context).pop();
  } else {
    playListProvider.addPlayList(newPlayList);
    final playListCreatedSnackBar = SnackBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
        backgroundColor: componentsColor,
        content: Text(
          'Playlist Created Successful',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.deepPurple[50]),
        ));
    ScaffoldMessenger.of(context).showSnackBar(playListCreatedSnackBar);
    Navigator.of(context).pop();
    nameController.clear();
  }
}
