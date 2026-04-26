/*
  adb connect 192.168.3.74
*/
import 'package:client_app/test_one.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TestOne(),
    ),
  );
}
