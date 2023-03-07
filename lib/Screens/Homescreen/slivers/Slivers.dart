import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:musician/Screens/Homescreen/Home.dart';

import '../../FavouriteScreen/Favourite.dart';
import '../../SearchScreen/SearchSreen.dart';
import '../PlayListHome/playlists.dart';

class SliverAppBarWidget extends StatelessWidget {
  const SliverAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: IconButton(
        onPressed: () {
          globalKey.currentState!.openDrawer();
        },
        icon: const Icon(
          Icons.settings,
          size: 28,
          color: Colors.white38,
        ),
      ),
      backgroundColor: Colors.transparent,
      collapsedHeight: 310,
      expandedHeight: 310,
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
          const PlayList(),
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
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                color: Colors.purple,
                width: 3,
              ),
            ),
            indicatorSize: TabBarIndicatorSize.label,
          ),
        ));
  }
}
