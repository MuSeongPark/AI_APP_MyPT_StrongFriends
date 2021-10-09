

import 'package:flutter/cupertino.dart';

class AppData with ChangeNotifier{
  bool _detecting = false;
  get detecting => _detecting;

  void playDetecting(){
    _detecting = true;
    notifyListeners();
  }

  void stopDetecting(){
    _detecting = false;
    notifyListeners();
  }
}