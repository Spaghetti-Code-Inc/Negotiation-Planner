import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utils {

  static final messengerKey = GlobalKey<ScaffoldMessengerState>();


  static showSnackBar(String? text){
    if (text == null) return;

    final snackBar = SnackBar(content: Text(text), backgroundColor: CupertinoColors.activeBlue);

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}