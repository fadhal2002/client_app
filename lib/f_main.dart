/*
  adb connect 192.168.3.74
*/
import 'package:client_app/core/servers/app_servers.dart';
import 'package:client_app/routs.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initalServices();
  runApp(const MyApp());
}

Future initalServices() async {
  await Get.putAsync(() => AppServices().init());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(getPages: routes);
  }
}
