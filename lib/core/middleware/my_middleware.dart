import 'package:client_app/core/servers/app_servers.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MyMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;
  AppServices appServices = Get.find();
  @override
  RouteSettings? redirect(String? route) {
    if (appServices.shared.getString('screen') == 'homePage') {
      return const RouteSettings(name: '/LoginScreen');
    }
    return null;
  }
}
