import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppServices extends GetxService {
  late SharedPreferences shared;

  Future<AppServices> init() async {
    shared = await SharedPreferences.getInstance();
    return this;
  }
}
