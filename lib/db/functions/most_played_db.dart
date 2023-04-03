// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:musician/presentation/Homescreen/widgets/all_music.dart';
// import 'package:on_audio_query/on_audio_query.dart';

// class MostPlayedDb {
//   static ValueNotifier<List<SongModel>> mostPlayedNotifier = ValueNotifier([]);
//   static List<dynamic> mostlyPlayed = [];

//   static Future<void> addSongsToMostly(songs) async {
//     final mostPlayedDb = await Hive.openBox('MostlyPlayed');
//     await mostPlayedDb.add(songs);
//     getMostPlayedSongs();
//     // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
//     mostPlayedNotifier.notifyListeners();
//   }

//   static Future<void> getMostPlayedSongs() async {
//     final mostPlayedDb = await Hive.openBox('MostlyPlayed');
//     mostlyPlayed = mostPlayedDb.values.toList();
//     displayMostPlayedSongs();
//     // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
//     mostPlayedNotifier.notifyListeners();
//   }

//   static Future<List> displayMostPlayedSongs() async {
//     final mostPlayedDb = await Hive.openBox('MostlyPlayed');
//     final mostPlayedItems = mostPlayedDb.values.toList();
//     mostPlayedNotifier.value.clear();
//     int count = 0;
//     for (var i = 0; i < mostPlayedItems.length; i++) {
//       for (var k = 0; k < mostPlayedItems.length; k++) {
//         if (mostPlayedItems[i] == mostPlayedItems[k]) {
//           count = count+1;
//         }
//       }
//       if (count > 4) {
//         for (var j = 0; j < startSong.length; j++) {
//           if (mostPlayedItems[i] == startSong[j].id) {
//             mostPlayedNotifier.value.add(startSong[j]);
//             mostlyPlayed.add(startSong[j]);
//           }
//         }
//         count = 0;
//       }
//     }
//     return mostlyPlayed;
//   }
// }
