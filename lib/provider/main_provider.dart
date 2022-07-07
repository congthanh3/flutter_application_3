import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier {
  //index of BottomNavigation Stack
  int _index = 0;

  get getIndex => _index;

  set isSelectIndex(int index) {
    _index = index;
    notifyListeners();
  }

  bool _visible = true;

  get getVisible => _visible;
  setVisible(bool visible) {
    _visible = visible;
    notifyListeners();
  }

  Locale _currentLocale = const Locale('vi');
  get getCurrentLocale => _currentLocale;

  void setLocale(String _locale) {
    _currentLocale = Locale(_locale);
    notifyListeners();
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  get getGlobalKey => _key;
}
