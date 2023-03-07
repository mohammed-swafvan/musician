import 'package:flutter/material.dart';
import 'package:musician/Themes/Colors.dart';

Future<void> showDeleteOption(BuildContext context) async {
  showDialog(
    context: context,
    builder: ((context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)
        ),
        backgroundColor: Colors.deepPurple[100],
        title: Text(
          'Delete!',
          style: TextStyle(fontWeight: FontWeight.w800, color: componentsColor),
        ),
        content: const Text(
          'Are you sure you want to Delete this Song ?',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'OK',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color:  componentsColor),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'CANCEL',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: componentsColor),              
            ),
          )
        ],
      );
    }),
  );
}
