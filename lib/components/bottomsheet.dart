import 'package:flutter/material.dart';
import 'package:musician/Lists/Lists.dart';
import 'package:musician/Themes/Colors.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../DB/functions/FavDbFunctions.dart';
import 'AllMusicMoreDialogu.dart';

Future<void> nowPlayingBottumSheet(BuildContext ctx, SongModel songs) async {
  showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      isScrollControlled: true,
      backgroundColor: componentsColor,
      context: ctx,
      builder: (ctx1) {
        return FractionallySizedBox(
          heightFactor: 0.3,
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: ListView.builder(
                itemCount: iconsForNowPlayingMore.length,
                itemBuilder: ((context, index) {
                  return ListTile(
                    onTap: (() {
                      if (index == 0) {
                        Navigator.pop(ctx);
                        showSongsDetails(ctx, songs);
                      } else if (index == 1) {
                        Navigator.pop(ctx);
                        if (FavDbFun.isFav(songs)) {
                          FavDbFun.deleteSong(songs.id);
                          final removeFromFav = SnackBar(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: componentsColor,
                            content: Text(
                              'Song Removed From Favourites',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.deepPurple[50]),
                            ),
                            duration: const Duration(seconds: 1),
                          );
                          ScaffoldMessenger.of(ctx).showSnackBar(removeFromFav);
                        } else {
                          FavDbFun.addSongs(songs);
                          final addedToFav = SnackBar(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: componentsColor,
                            content: Text(
                              'Song Added To Favourite',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.deepPurple[50]),
                            ),
                            duration: const Duration(seconds: 1),
                          );
                          ScaffoldMessenger.of(ctx).showSnackBar(addedToFav);
                        }
                        FavDbFun.favSongsNotifier.notifyListeners();
                      } else if (index == 2) {
                        Navigator.pop(ctx);
                        showPlayListDialog(ctx, songs);
                      }
                    }),
                    leading: Icon(
                      iconsForNowPlayingMore[index],
                      color: Colors.deepPurple[50],
                      size: 30,
                    ),
                    title: Text(
                      optionsForNowPlayingMore[index],
                      style: TextStyle(color: Colors.deepPurple[50], fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  );
                })),
          ),
        );
      });
}

