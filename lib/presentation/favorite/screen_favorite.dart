import 'package:flutter/material.dart';
import 'package:musician/controller/Provider/favorite/favorite_provider.dart';
import 'package:musician/controller/core/themes/usually_colors.dart';
import 'package:musician/controller/core/themes/back_gound_design.dart';
import 'package:musician/presentation/widgets/back_drop_widget.dart';
import 'package:musician/presentation/widgets/list_tile_widget.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: bgColor,
          body: Stack(
            children: [
              const Blue(),
              const Purple(),
              const BackdropWidget(),
              SizedBox(
                child: ListView(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          child: Image.asset(
                            'Assets/Images/favourite.webp',
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.3,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: ListTile(
                            leading: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: 28,
                                color: Colors.white38,
                              ),
                            ),
                            trailing: CircleAvatar(
                              backgroundColor: const Color.fromARGB(255, 40, 18, 140),
                              radius: 22,
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.favorite,
                                  size: 28,
                                  color: Colors.white38,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 170, left: 20),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 32,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Favourites',
                                style: TextStyle(
                                  shadows: [Shadow(offset: Offset(4.0, 4.0), blurRadius: 3.0, color: Colors.white10)],
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 38,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Consumer<FavoriteProvider>(
                          builder: (context, value, _) {
                            if (value.favoriteSongs.isEmpty) {
                              return const SizedBox(
                                height: 500,
                                child: Center(
                                  child: Text(
                                    'No Favourite Songs',
                                    style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              );
                            } else {
                              final temp = value.favoriteSongs.reversed.toList();
                              return ListTileWidget(songModel: temp);
                            }
                          },
                        ))
                  ],
                ),
              )
            ],
          ),
        );
  }
}
