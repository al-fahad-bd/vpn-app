import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:vpn_app/app_preferences/app_preferences.dart';
import 'package:vpn_app/modules/screens/splash_screen.dart';
import 'package:vpn_app/core/theme/dark_theme.dart';
import 'package:vpn_app/core/theme/light_theme.dart';

late Size sizeOfScreen;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppPreferences.initHive();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: Get.deviceLocale, // Automatically detects the device locale
      fallbackLocale: const Locale('en', 'US'),
      title: 'Flutter VPN',
      // theme: ThemeData(
      //   appBarTheme: const AppBarTheme(
      //     centerTitle: true,
      //     elevation: 3,
      //   ),
      // ),
      // themeMode: AppPreferences.isModeDark ? ThemeMode.dark : ThemeMode.light,
      // darkTheme: ThemeData(
      //   brightness: Brightness.dark,
      //   appBarTheme: const AppBarTheme(
      //     centerTitle: true,
      //     elevation: 3,
      //   ),
      // ),
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const SplashScreen(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('bn', 'BD'), // Example: Add Bengali for Bangladesh
      ],
    );
  }
}

extension AppTheme on ThemeData {
  Color get lighTextColor =>
      AppPreferences.isModeDark ? Colors.white70 : Colors.black54;
  Color get bottomNavigationColor =>
      AppPreferences.isModeDark ? Colors.white12 : Colors.redAccent;
}
