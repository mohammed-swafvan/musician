import 'package:flutter/material.dart';
import 'package:musician/controller/core/list/list.dart';
import 'package:musician/controller/core/themes/usually_colors.dart';
import 'package:musician/presentation/settings/widgets/about_us.dart';
import 'package:musician/presentation/settings/widgets/feed_back.dart';
import 'package:musician/presentation/settings/widgets/privacy_policy.dart';
import 'package:musician/presentation/settings/widgets/terms_conditions.dart';
import 'package:musician/controller/core/components/settings_dailoge.dart';

class SettingsSideBar extends StatelessWidget {
  const SettingsSideBar({super.key});


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
