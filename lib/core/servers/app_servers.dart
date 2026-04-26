import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppServices extends ChangeNotifier {
  static const String loginKey = 'isLoggedIn';

  late SharedPreferences shared;

  bool _isLoggedIn = false;
  bool _isLoading = true;

  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;

  Future<AppServices> init() async {
    shared = await SharedPreferences.getInstance();
    _isLoggedIn = shared.getBool(loginKey) ?? false;

    _isLoading = false;
    notifyListeners();

    return this;
  }

  Future<void> login() async {
    await shared.setBool(loginKey, true);
    _isLoggedIn = true;
    notifyListeners();
  }

  Future<void> logout() async {
    await shared.setBool(loginKey, false);
    _isLoggedIn = false;
    notifyListeners();
  }
}