import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class ToastService{
  void tst(String msg, Color backgroundColor){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: backgroundColor,
        textColor: Colors.white
      );
  }
}