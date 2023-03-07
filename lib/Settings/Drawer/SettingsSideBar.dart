import 'package:flutter/material.dart';
import 'package:musician/Lists/Lists.dart';
import 'package:musician/Settings/AboutUs.dart';
import 'package:musician/Settings/FeedBack.dart';
import 'package:musician/Settings/Privacy&Policy.dart';
import 'package:musician/Settings/Terms&Condtions.dart';
import 'package:musician/Themes/Colors.dart';
import 'package:musician/components/SettonsDialogs.dart';

class SettingsSideBar extends StatefulWidget {
  const SettingsSideBar({super.key});

  @override
  State<SettingsSideBar> createState() => SettingsSideBarState();
}

class SettingsSideBarState extends State<SettingsSideBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: componentsColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50, top: 20),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '   Settings',
                      style: TextStyle(
                        shadows: [Shadow(offset: Offset(4.0, 4.0), blurRadius: 3.0, color: Colors.white10)],
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.white54,
                    )
                  ],
                )),
            SizedBox(
              height: 385,
              width: double.infinity,
              child: ListView.builder(
                controller: ScrollController(keepScrollOffset: false),
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20, top: 8),
                    child: GestureDetector(
                      onTap: () {
                        if (index == 0) {
                          Navigator.pop(context);
                          resetInSettings(context);
                        } else if (index == 1) {
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const PrivacyPolicy()));
                        } else if (index == 2) {
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const TermsConditions()));
                        } else if (index == 4) {
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  FeedBack()));
                        } else if (index == settingsList.length - 1) {
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutUs()));
                        }
                      },
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Wrap(
                                children: [
                                  Icon(
                                    settingsIcon[index],
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text(settingsList[index],
                                      style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500)),
                                ],
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white60,
                                size: 16,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Divider(
                            thickness: 1,
                            color: Colors.white54,
                          )
                        ],
                      ),
                    ),
                  );
                }),
                itemCount: settingsList.length,
              ),
            ),
            Column(
              children: const [
                Text('Version',
                    style: TextStyle(
                      color: Colors.white54,
                      fontWeight: FontWeight.w300,
                    )),
                Text('0.01',
                    style: TextStyle(
                      color: Colors.white60,
                      fontWeight: FontWeight.w400,
                    )),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
