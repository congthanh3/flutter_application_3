import 'package:flutter/material.dart';

import '../constants/all_constants.dart';

class PhotoProvider extends ChangeNotifier {
  final List _photos = [AppAssets.wolf, AppAssets.cat];
  int _index = 0;

  List get getPhoto => _photos;
  int get getIndex => _index;

  moveUp() {
    _index++;
    notifyListeners();

    print(_index);
    print("_index");
  }

  moveDown() {
    _index--;
    notifyListeners();
    print(_index);
  }
}
