import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:musician/Provider/SongModelProvider.dart';
import 'package:musician/Screens/Splash.dart';
import 'package:musician/Themes/Colors.dart';
import 'package:provider/provider.dart';
import 'DB/Models/Song_model.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: componentsColor,
      ),
      home: const SplashScreen(),
    );
  }
}
