import 'package:flutter/material.dart';
import 'package:musician/DB/functions/PlayListDb.dart';

import '../Themes/Colors.dart';

Future<void> resetInSettings(BuildContext context) async {
  showDialog(
    context: context,
    builder: ((ctx) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.deepPurple[50],
        title: Text(
          'Alert!',
          style: TextStyle(fontWeight: FontWeight.w600, color: componentsColor),
        ),
        content: const Text(
          'Are you sure you want to reset the app',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: Text(
              'Cancel',
              style: TextStyle(fontWeight: FontWeight.w500, color: componentsColor),
            ),
          ),
          TextButton(
            onPressed: () {
              PlayListDb.resetApp(ctx);
              Navigator.pop(ctx);
            },
            child: Text(
              'OK',
              style: TextStyle(fontWeight: FontWeight.w500, color: componentsColor),
            ),
          )
        ],
      );
    }),
  );
}
