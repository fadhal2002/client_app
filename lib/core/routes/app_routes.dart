import 'package:client_app/screen/view/auth/login._screen.dart';
import 'package:client_app/screen/view/auth/name_input.dart';
import 'package:client_app/screen/view/auth/otp_verification.dart';
import 'package:client_app/screen/view/home/HomePage/AddDelivery/Location_Picker_screen.dart';
import 'package:client_app/screen/view/home/HomePage/AddDelivery/ride_confirmation_screen.dart';
import 'package:client_app/screen/view/home/HomePage/AddDelivery/route_map_screen.dart';
import 'package:client_app/screen/view/home/HomePage/home_screen.dart';
import 'package:client_app/screen/view/home/HomePage/home_screen_state.dart';
import 'package:client_app/screen/view/home/settings/about_us_screen.dart';
import 'package:client_app/screen/view/home/settings/edit_profile_screen.dart';
import 'package:client_app/screen/view/home/settings/help_center_screen.dart';
import 'package:client_app/screen/view/home/settings/language_screen.dart';
import 'package:client_app/screen/view/home/settings/settings_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String loginScreen = '/LoginScreen';
  static const String otpVerification = '/OtpVerification';
  static const String nameInput = '/NameInput';
  static const String homePageState = '/HomePageState';
  static const String homeScreen = '/HomeScreen';
  static const String settingsScreen = '/SettingsScreen';
  static const String languageScreen = '/LanguageScreen';
  static const String editProfileScreen = '/EditProfileScreen';
  static const String aboutUsScreen = '/AboutUsScreen';
  static const String helpCenterScreen = '/HelpCenterScreen';
  static const String addDeliveryScreen = '/AddDeliveryScreen';
  static const String locationPickerScreen = '/LocationPickerScreen';
  static const String routeMapScreen = '/RouteMapScreen';

  static Map<String, WidgetBuilder> get routes {
    return {
      loginScreen: (context) => const LoginScreen(),
      otpVerification: (context) => const OtpVerification(),
      nameInput: (context) => const NameInput(),
      homePageState: (context) => const HomeScreenState(),
      homeScreen: (context) => const HomeScreen(),
      settingsScreen: (context) => const SettingsScreen(),
      languageScreen: (context) => const LanguageScreen(),
      editProfileScreen: (context) => const EditProfileScreen(),
      aboutUsScreen: (context) => const AboutUsScreen(),
      helpCenterScreen: (context) => const HelpCenterScreen(),
      // addDeliveryScreen: (context) => const AddDeliveryScreen(),
      locationPickerScreen: (context) => const LocationPickerScreen(),
      routeMapScreen: (context) => RouteMapScreen(),
    };
  }
}
