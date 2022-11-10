import 'package:flutter/material.dart';
import 'package:todolist/models/usermodel.dart';
import 'package:todolist/screens/dashboard.dart';
import 'package:todolist/screens/login.dart';



void main() {
  UserModel user=UserModel("jason", "jasonkhadka2000@gmail.com", "dummypassword");
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(user,[]),
  ));
}


