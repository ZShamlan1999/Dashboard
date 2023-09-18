import 'package:flutter/cupertino.dart';

class MyProvider with ChangeNotifier {
  int curentPageIndex = 0;
  changeCurentPageIndex(int index) {
    curentPageIndex = index;
    notifyListeners();
  }
}
