import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void notifyUser(String message)
{
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 14.0
  );
}