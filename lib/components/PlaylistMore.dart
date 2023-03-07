import 'package:flutter/material.dart';
import 'package:musician/DB/Models/Song_model.dart';
import 'package:musician/DB/functions/PlayListDb.dart';
import 'package:musician/Lists/Lists.dart';
import 'package:musician/Themes/Colors.dart';

Future<void> playListMore(BuildContext context, indexes, musicList, formKey, playListNameController, data) async {
  showModalBottomSheet(
      backgroundColor: componentsColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      context: context,
      builder: ((context) {
        return FractionallySizedBox(
          heightFactor: 0.3,
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: ListView.builder(
                itemCount: iconsForPlayListMore.length,
                itemBuilder: ((context, index) {
                  return ListTile(
                    leading: Icon(
                      iconsForPlayListMore[index],
                      color: Colors.white,
                      size: 30,
                    ),
                    title: Text(
                      optionsForPlayListMore[index],
                      style: TextStyle(color: Colors.deepPurple[50], fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    onTap: () {
                      if (index == 0) {
                        Navigator.of(context).pop();
                        showdialog(context, musicList, indexes);
                      } else {
                        Navigator.pop(context);
                        playListNameController.clear();
                        editplaylist(indexes, context, formKey, playListNameController, data);
                      }
                    },
                  );
                })),
          ),
        );
      }));
}

Future<void> updateplaylistname(index, formkey, playlistnamectrl) async {
  if (formkey.currentState!.validate()) {
    final names = playlistnamectrl.text.trim();
    if (names.isEmpty) {
      return;
    } else {
      final playlistnam = SongsDataBase(name: names, songId: []);
      PlayListDb.editPlaylist(index, playlistnam);
    }
  }
}

Future editplaylist(index, context, formkey, playlistnamectrl, SongsDataBase playListName) {
  playlistnamectrl = TextEditingController(text: playListName.name);
  return showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      backgroundColor: Colors.deepPurple[50],
      children: [
        SimpleDialogOption(
          child: Text(
            'Edit Playlist Name',
            textAlign: TextAlign.center,
            style: TextStyle(color: componentsColor, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SimpleDialogOption(
          child: Form(
            key: formkey,
            child: TextFormField(
              maxLength: 14,
              controller: playlistnamectrl,
              decoration: InputDecoration(
                  fillColor: Colors.white60,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  contentPadding: const EdgeInsets.only(left: 15, top: 5)),
              style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter your playlist name";
                } else {
                  return null;
                }
              },
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: componentsColor, fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                updateplaylistname(index, formkey, playlistnamectrl);
                Navigator.pop(context);
              },
              child: Text(
                'Update',
                style: TextStyle(color: componentsColor, fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Future<dynamic> showdialog(context, musicList, indexes) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.deepPurple[50],
        title: Text(
          'Delete Playlist',
          style: TextStyle(color: componentsColor, fontSize: 17, fontWeight: FontWeight.w600),
        ),
        content: const Text(
          'Are you sure you want to delete this playlist?',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'No',
              style: TextStyle(
                color: componentsColor,
                fontSize: 15,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              musicList.deleteAt(indexes);
              Navigator.pop(context);
              final snackBar = SnackBar(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                behavior: SnackBarBehavior.floating,
                backgroundColor: componentsColor,
                content: Text(
                  'Playlist is deleted',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.deepPurple[50]),
                ),
                duration: const Duration(milliseconds: 450),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            child: Text(
              'Yes',
              style: TextStyle(
                color: componentsColor,
                fontSize: 15,
              ),
            ),
          ),
        ],
      );
    },
  );
}
