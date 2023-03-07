import 'package:flutter/material.dart';
import 'package:musician/Screens/AllMusic/AllMusic.dart';
import 'package:musician/Screens/Homescreen/slivers/Slivers.dart';
import 'package:musician/Screens/Miniplayer/miniPlayer.dart';
import 'package:musician/Screens/mostplayed/mostplayed.dart';
import 'package:musician/Themes/Colors.dart';
import 'package:musician/Settings/Drawer/SettingsSideBar.dart';
import 'package:musician/controller/GetAllSongsController.dart';
import 'package:musician/Themes/BackGroundDesign.dart';
import 'package:musician/Screens/Recently/Recently.dart';
import '../../Themes/BackDropWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: globalKey,
        drawer: const Drawer(
          child: SettingsSideBar(),
        ),
        backgroundColor: bgColor,
        body: SafeArea(
          child: Stack(
            children: [
              const Blue(),
              const Purple(),
              const BackdropWidget(),
              NestedScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  headerSliverBuilder: (context, isScrollable) {
                    return [const SliverAppBarWidget(), const SliverPresistendHeaderWidget()];
                  },
                  body: const Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: TabBarView(children: [ALlMusic(), RecentlyPlayed(), MostPlayed()]),
                  )),
              (GetAllSongController.audioPlayer.currentIndex != null) ? const MiniPlayer() : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}

class MyDelegate extends SliverPersistentHeaderDelegate {
  MyDelegate(this.tabBar);

  final TabBar tabBar;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.transparent,
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
