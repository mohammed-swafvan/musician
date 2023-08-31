import 'package:flutter/material.dart';
import 'package:musician/controller/Provider/splah/splash_provider.dart';
import 'package:musician/controller/core/themes/usually_colors.dart';
import 'package:musician/controller/core/themes/back_gound_design.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../widgets/back_drop_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SplashProvider>(context, listen: false).gotoHomeScreen(context);
    });
    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          const Blue(),
          const Purple(),
          const BackdropWidget(),
          SafeArea(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
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
}
