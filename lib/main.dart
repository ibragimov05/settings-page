import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:settings_page/utils/app_constants.dart';
import 'package:settings_page/views/screens/home_screen.dart';
import 'package:settings_page/views/screens/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void toggleThemeMode(bool value) async {
    AppConstants.themeMode = value ? ThemeMode.dark : ThemeMode.light;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('isDark', '$value');
    setState(() {});
  }

  void onBackgroundChanged(String imageUrl) async {
    AppConstants.imageUrl = imageUrl;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('image', imageUrl);
    setState(() {});
  }

  void onLanguageChanged(String language) async {
    AppConstants.language = language;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('language', language);
    setState(() {});
  }

  void onColorChanged(Color color) async {
    AppConstants.appColor = color;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt('app-color', color.value);
    setState(() {});
  }

  void onTextChanged(Color color, double size) async {
    AppConstants.textSize = size;
    AppConstants.textColor = color;
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setString(
      'text-val',
      jsonEncode(
        {
          'text-size': size,
          'text-color': color.value,
        },
      ),
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    AppConstants().setConstants().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: AppConstants.appColor,
        ),
      ),
      darkTheme: ThemeData.dark(),
      themeMode: AppConstants.themeMode,
      home: HomeScreen(
        onThemeChanged: toggleThemeMode,
        onBackgroundChanged: onBackgroundChanged,
        onLanguageChanged: onLanguageChanged,
        onColorChanged: onColorChanged,
        onTextChanged: onTextChanged,
      ),
    );
  }
}
