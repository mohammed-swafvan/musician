import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:musician/models/Song_model.dart';
import 'package:musician/controller/Provider/favorite/favorite_provider.dart';
import 'package:musician/controller/Provider/mostly_played/mostly_played_provider.dart';
import 'package:musician/controller/Provider/now_playing/play_controls_provider.dart';
import 'package:musician/controller/Provider/playlists/playlist_provider.dart';
import 'package:musician/controller/Provider/recenly_played/recenetly_played_provider.dart';
import 'package:musician/controller/Provider/search/search_provider.dart';
import 'package:musician/controller/Provider/song_model_provider.dart';
import 'package:musician/controller/Provider/splah/splash_provider.dart';
import 'package:musician/controller/core/themes/usually_colors.dart';
import 'package:musician/presentation/splash/screen_splash.dart';
import 'package:musician/controller/Provider/all_music/all_music_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!Hive.isAdapterRegistered(SongsDataBaseAdapter().typeId)) {
    Hive.registerAdapter(SongsDataBaseAdapter());
  }

  await Hive.initFlutter();
  await Hive.openBox<int>('FavDb');
  await Hive.openBox<SongsDataBase>('PlayListDb');
  await Hive.openBox('MostlyPlayed');
  await Hive.openBox('RecentlyPlay');

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(ChangeNotifierProvider(
    create: (context) => SongModelProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SplashProvider()),
        ChangeNotifierProvider(create: (context) => AllMusicProvider()),
        ChangeNotifierProvider(create: (context) => RecentlyPlayedProvider()),
        ChangeNotifierProvider(create: (context) => FavoriteProvider()),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
        ChangeNotifierProvider(create: (context) => MostlyPlayedProvider()),
        ChangeNotifierProvider(create: (context) => PlayListProvider()),
        ChangeNotifierProvider(create: (context) => PlayControlsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          primaryColor: componentsColor,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
