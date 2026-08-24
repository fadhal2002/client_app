import 'package:client_app/screen/view/auth/login_screen.dart';
import 'package:client_app/screen/view/auth/name_input_and_account_type.dart';
import 'package:client_app/screen/view/auth/otp_verification.dart';
import 'package:client_app/screen/view/auth/ware_house_address_screen.dart';
import 'package:client_app/screen/view/home/HomePage/AddDelivery/Location_Picker_screen.dart';
// import 'package:client_app/screen/view/home/HomePage/AddDelivery/Location_Picker_screen.dart';
// import 'package:client_app/screen/view/home/HomePage/AddDelivery/ride_confirmation_screen.dart';
import 'package:client_app/screen/view/home/HomePage/AddDelivery/route_map_screen.dart';
import 'package:client_app/screen/view/home/HomePage/home_screen.dart';
import 'package:client_app/screen/view/home/HomePage/home_screen_state.dart';
import 'package:client_app/screen/view/home/HomePage/orders_history_screen.dart';
import 'package:client_app/screen/view/home/settings/about_us_screen.dart';
import 'package:client_app/screen/view/home/settings/edit_profile_screen.dart';
import 'package:client_app/screen/view/home/settings/help_center_screen.dart';
import 'package:client_app/screen/view/home/settings/language_screen.dart';
import 'package:client_app/screen/view/home/settings/location_setup_screen.dart';
import 'package:client_app/screen/view/home/settings/settings_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String loginScreen = '/LoginScreen';
  static const String otpVerification = '/OtpVerification';
  static const String nameInputAndAccountType = '/NameInputAndAccountType';
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
  static const String ordersHistoryScreen = '/OrdersHistoryScreen';
  static const String locationSetupScreen = '/LocationSetupScreen';
  static const String warehouseAddressScreen = '/WarehouseAddressScreen';

  static Map<String, WidgetBuilder> get routes {
    return {
      loginScreen: (context) => const LoginScreen(),
      otpVerification: (context) => const OtpVerification(),
      nameInputAndAccountType: (context) => const NameInputAndAccountType(),
      homePageState: (context) => const HomeScreenState(),
      homeScreen: (context) => const HomeScreen(),
      settingsScreen: (context) => const SettingsScreen(),
      languageScreen: (context) => const LanguageScreen(),
      editProfileScreen: (context) => const EditProfileScreen(),
      aboutUsScreen: (context) => const AboutUsScreen(),
      helpCenterScreen: (context) => const HelpCenterScreen(),
      routeMapScreen: (context) => RouteMapScreen(),
      ordersHistoryScreen: (context) => OrdersHistoryScreen(),
      locationPickerScreen : (context) => LocationPickerScreen(),
      locationSetupScreen : (context) => LocationSetupScreen(),
      warehouseAddressScreen : (context) => WarehouseAddressScreen(),
    };
  }
}
