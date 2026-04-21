import 'package:client_app/core/middleware/my_middleware.dart';
import 'package:client_app/screen/view/auth/login._screen.dart';
import 'package:client_app/screen/view/auth/name_input.dart';
import 'package:client_app/screen/view/auth/otp_verification.dart';
import 'package:client_app/screen/view/home/HomePage/AddDelivery/Location_Picker_screen.dart';
import 'package:client_app/screen/view/home/HomePage/AddDelivery/add_delivery_screen.dart';
import 'package:client_app/screen/view/home/HomePage/AddDelivery/route_map_screen.dart';
import 'package:client_app/screen/view/home/HomePage/home_screen.dart';
import 'package:client_app/screen/view/home/HomePage/home_screen_state.dart';
import 'package:client_app/screen/view/home/settings/about_us_screen.dart';
import 'package:client_app/screen/view/home/settings/edit_profile_screen.dart';
import 'package:client_app/screen/view/home/settings/help_center_screen.dart';
import 'package:client_app/screen/view/home/settings/language_screen.dart';
import 'package:client_app/screen/view/home/settings/settings_screen.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/route_manager.dart';

final List<GetPage> routes = [
  GetPage(
    name: '/',
    page: () => const LoginScreen(),
    middlewares: [MyMiddleware()],
  ),
  GetPage(name: '/LoginScreen', page: () => const LoginScreen()),
  GetPage(name: '/OtpVerification', page: () => const OtpVerification()),
  GetPage(name: '/NameInput', page: () => const NameInput()),
  GetPage(name: '/HomePageState', page: () => const HomeScreenState()),
  GetPage(name: '/HomeScreen', page: () => const HomeScreen()),
  GetPage(name: '/SettingsScreen', page: () => const SettingsScreen()),
  GetPage(name: '/LanguageScreen', page: () => const LanguageScreen()),
  GetPage(name: '/EditProfileScreen', page: () => const EditProfileScreen()),
  GetPage(name: '/AboutUsScreen', page: () => const AboutUsScreen()),
  GetPage(name: '/HelpCenterScreen', page: () => const HelpCenterScreen()),
  GetPage(name: '/AddDeliveryScreen', page: () => const AddDeliveryScreen()),
  GetPage(name: '/LocationPickerScreen', page: () => LocationPickerScreen()),
  GetPage(name: '/RouteMapScreen', page: () => RouteMapScreen()),
];
