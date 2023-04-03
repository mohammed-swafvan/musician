import 'package:flutter/material.dart';

import '../list/list.dart';
import '../themes/usually_colors.dart';

Future<void> favouriteMore(BuildContext context) async {
  showModalBottomSheet(
      backgroundColor: componentsColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      context: context,
      builder: ((context) {
        return FractionallySizedBox(
          heightFactor: 0.3,
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: ListView.builder(
                itemCount: iconsForFavoritemore.length,
                itemBuilder: ((context, index) {
                  return ListTile(
                    leading: IconButton(
                      icon: Icon(
                        iconsForFavoritemore[index],
                        size: 32,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                    title: Text(
                      optionsForFavoriteMore[index],
                      style: TextStyle(color: Colors.deepPurple[50], fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  );
                })),
          ),
        );
      }));
}
