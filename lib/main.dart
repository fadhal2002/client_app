import 'package:client_app/core/routes/app_routes.dart' show AppRoutes;
import 'package:client_app/core/servers/app_servers.dart';
import 'package:client_app/screen/view/auth/login._screen.dart';
import 'package:client_app/screen/view/home/HomePage/home_screen_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final appServices = await AppServices().init();

  runApp(
    ChangeNotifierProvider.value(value: appServices, child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MaterialApp(
        // locale: const Locale('ar'),
        // supportedLocales: const [Locale('ar')],

        // theme: ThemeData(fontFamily: 'Cairo'),

        builder: (context, child) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: child!,
          );
        },

        routes: AppRoutes.routes,

        // ✅ Provider controls first screen
        home: Consumer<AppServices>(
          builder: (context, app, _) {
            if (app.isLoading) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            return app.isLoggedIn
                ? const HomeScreenState()
                : const LoginScreen();
          },
        ),
      ),
    );
  }
}
