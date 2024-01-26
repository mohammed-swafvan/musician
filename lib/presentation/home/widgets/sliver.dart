import 'package:flutter/material.dart';

import '../../favorite/screen_favorite.dart';
import '../../search/screen_search.dart';
import 'PlayListHome/playlists.dart';

class SliverAppBarWidget extends StatelessWidget {
  const SliverAppBarWidget({super.key, required this.settingsGlobalKey});
  final GlobalKey<ScaffoldState> settingsGlobalKey;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      collapsedHeight: screenHeight * 0.36,
      expandedHeight: screenHeight * 0.36,
      leading: IconButton(
        onPressed: () {
          settingsGlobalKey.currentState!.openDrawer();
        },
        icon: const Icon(
          Icons.settings,
          size: 28,
          color: Colors.white38,
        ),
      ),
      flexibleSpace: Column(
        children: [
          ListTile(
            trailing: Wrap(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: ((context) => const FavouriteScreen())));
                  },
                  icon: const Icon(
                    Icons.favorite,
                    size: 28,
                    color: Colors.white38,
                  ),
                ),
                CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 40, 18, 140),
                  radius: 22,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: ((context) => const SearchScreen())));
                    },
                    icon: const Icon(
                      Icons.search_rounded,
                      size: 28,
                      color: Colors.white38,
                    ),
                  ),
                ),
              ],
            ),
          ),
          PlayList(),
        ],
      ),
    );
  }
}

class SliverPresistendHeaderWidget extends StatelessWidget {
  const SliverPresistendHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      floating: true,
      delegate: MyDelegate(
        const TabBar(
          tabs: [
            Tab(
              text: 'All music',
            ),
            Tab(
              text: 'Recently Played',
            ),
            Tab(
              text: 'Mostly Played',
            ),
          ],
          dividerColor: Colors.transparent,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
              color: Colors.purple,
              width: 3,
            ),
          ),
          indicatorSize: TabBarIndicatorSize.label,
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
