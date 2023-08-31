

import 'package:flutter/material.dart';
import 'package:musician/presentation/home/screen_home.dart';

class SplashProvider with ChangeNotifier {
  Future<void> gotoHomeScreen(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 1700));
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const HomeScreen(),
    ));
  }

}
