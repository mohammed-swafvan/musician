import 'package:flutter/material.dart';
import 'package:musician/Screens/Homescreen/Home.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../Themes/BackDropWidget.dart';
import '../Themes/BackGroundDesign.dart';
import '../Themes/Colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    gotoHomeScreen();
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.music_note_sharp,
                    shadows: [Shadow(offset: Offset(5.0, 5.0), blurRadius: 10.0, color: Colors.black)],
                    size: 150,
                    color: Color.fromARGB(255, 112, 21, 145),
                  ),
                  const Text(
                    'Musician',
                    style: TextStyle(
                      letterSpacing: 2,
                      shadows: [Shadow(offset: Offset(4.0, 4.0), blurRadius: 3.0, color: Colors.black)],
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 103, 21, 133),
                      fontSize: 45,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 60),
                    child: LinearPercentIndicator(
                      animation: true,
                      animationDuration: 1500,
                      percent: 1,
                      progressColor: const Color.fromARGB(255, 112, 21, 145),
                      backgroundColor: const Color.fromARGB(255, 184, 89, 218),
                      barRadius: const Radius.circular(10),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> gotoHomeScreen() async {
    await Future.delayed(const Duration(milliseconds: 2100));
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const HomeScreen(),
    ));
  }
}
