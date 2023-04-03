
import 'package:flutter/material.dart';
import 'package:musician/controller/core/themes/back_gound_design.dart';
import 'package:musician/controller/core/themes/usually_colors.dart';
import 'package:musician/presentation/widgets/back_drop_widget.dart';
import 'package:musician/presentation/home/widgets/all_music.dart';
import 'package:musician/presentation/home/widgets/sliver.dart';
import 'package:musician/presentation/mini_player/mini_player.dart';
import 'package:musician/presentation/home/widgets/mostplayed.dart';
import 'package:musician/presentation/settings/settings.dart';
import 'package:musician/controller/get_all_music_controller.dart';
import 'package:musician/presentation/home/widgets/recently_played.dart';



GlobalKey<ScaffoldState> settingsGlobalKey = GlobalKey<ScaffoldState>();
class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  
  @override
  Widget build(BuildContext context) {
    
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: settingsGlobalKey,
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
                  body:  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: TabBarView(children: [AllMusic(), RecentlyPlayed(), MostPlayed()]),
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
    return tabBar;
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
