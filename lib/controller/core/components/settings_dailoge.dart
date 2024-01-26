import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musician/controller/Provider/favorite/favorite_provider.dart';
import 'package:musician/controller/core/themes/usually_colors.dart';
import 'package:musician/models/Song_model.dart';
import 'package:musician/presentation/splash/screen_splash.dart';
import 'package:provider/provider.dart';

Future<void> resetInSettings(BuildContext context) async {
  showDialog(
    context: context,
    builder: ((ctx) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.deepPurple[50],
        title: Text(
          'Alert!',
          style: TextStyle(fontWeight: FontWeight.w600, color: componentsColor),
        ),
        content: const Text(
          'Are you sure you want to reset the app',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: Text(
              'Cancel',
              style: TextStyle(fontWeight: FontWeight.w500, color: componentsColor),
            ),
          ),
          TextButton(
            onPressed: () {
              resetApp(ctx);
              Navigator.pop(ctx);
            },
            child: Text(
              'OK',
              style: TextStyle(fontWeight: FontWeight.w500, color: componentsColor),
            ),
          )
        ],
      );
    }),
  );
}

Future<void> resetApp(BuildContext context) async {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SplashScreen()));
  Provider.of<FavoriteProvider>(context, listen: false).favoriteSongs.clear();

  final playListDb = Hive.box<SongsDataBase>('PlayListDb');
  final recentlyplayDb = await Hive.openBox('RecentlyPlay');
  final musicDb = Hive.box<int>('FavDb');
  final mostPlayedDb = await Hive.openBox('MostlyPlayed');

  await playListDb.clear();
  await recentlyplayDb.clear();
  await musicDb.clear();
  await mostPlayedDb.clear();
}
