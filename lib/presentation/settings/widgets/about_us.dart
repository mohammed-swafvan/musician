
import 'package:flutter/material.dart';
import 'package:musician/controller/core/themes/back_gound_design.dart';
import 'package:musician/controller/core/themes/usually_colors.dart';
import 'package:musician/presentation/widgets/back_drop_widget.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

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
                child: Column(
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
                      title: const Text(
                        'About Us',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                            width: double.infinity,
                            decoration:
                                BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(30)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Welcome to Musician Application. We are dedicated to providing you the very best quality of sound and music varient, with an emphasis on new features. playlists, recently played songs, mostly played songs and favourites, and a rich user experience.",
                                    style: TextStyle(
                                        color: Colors.deepPurple[100], fontWeight: FontWeight.w500, fontSize: 16, height: 1.3),
                                  ),
                                  Text(
                                    "Founded in 2023 by Mohammed Swafvan PP. Musician app is our first major project with a basic performance of music hub and creates a better versions in future. Musician gives you the best music experience that you never had. it includes attractive mode of UI's and good practices.",
                                    style: TextStyle(
                                        color: Colors.deepPurple[100], fontWeight: FontWeight.w500, fontSize: 16, height: 1.3),
                                  ),
                                  Text(
                                    "It gives good quality and had increased the settings to power up the system as well as to provide better music rythms.",
                                    style: TextStyle(
                                        color: Colors.deepPurple[100], fontWeight: FontWeight.w500, fontSize: 16, height: 1.3),
                                  ),
                                  Text(
                                    "We hope you enjoy our music as much as we enjoy offering them to you. if you have any questions or comments, please don't hesitate to contact us.",
                                    style: TextStyle(
                                        color: Colors.deepPurple[100], fontWeight: FontWeight.w500, fontSize: 16, height: 1.3),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Sincerely,",
                                          style:
                                              TextStyle(color: Colors.deepPurple[100], fontWeight: FontWeight.w500, fontSize: 16),
                                        ),
                                        Text(
                                          "Mohammed Swafvan pp",
                                          style:
                                              TextStyle(color: Colors.deepPurple[100], fontWeight: FontWeight.bold, fontSize: 18),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
