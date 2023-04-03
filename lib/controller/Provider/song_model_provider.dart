
import 'package:flutter/material.dart';

class SongModelProvider with ChangeNotifier {
  int id = 0;

  int get getId => id;

  void setId(int id) {
    this.id = id;
    notifyListeners();
  }
}
