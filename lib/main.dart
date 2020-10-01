import 'package:flutter/material.dart';
import 'package:pin/data/data.dart';
import 'package:pin/screens/favourite.dart';
import 'package:pin/screens/homescreen.dart';
import 'package:pin/screens/setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SharedPreferences _sharedPreferences;
  Brightness _brightness = Brightness.light;
  MaterialColor _primarySwatch = Colors.indigo;
  MaterialAccentColor _accentColor = Colors.pinkAccent;

  @override
  void initState() {
    super.initState();
    getDefaults();
  }

  void getDefaults() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      _brightness = _sharedPreferences.getInt(kPreferenceBrightnessKey) == 0
          ? Brightness.dark
          : Brightness.light;
      _primarySwatch = primarySwatches[
              _sharedPreferences.getString(kPreferencePrimarySwatchKey)] ??
          Colors.indigo;
      _accentColor = accentColors[
              _sharedPreferences.getString(kPreferenceAccentColorKey)] ??
          Colors.pinkAccent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: _brightness,
        primarySwatch: _primarySwatch,
        accentColor: _accentColor,
      ),
      initialRoute: '/Home',
      routes: {
        '/Home': (context) => HomeScreen(),
        '/Favourite': (context) => Favourite(),
        '/detail': (context) => Detail(),
        '/Setting': (context) => SettingsScreen(
            updateBrightness, updatePrimarySwatch, updateAccentColor),
      },
    );
  }

  void updateBrightness(Brightness brightness) {
    setState(() {
      _brightness = brightness;
      print(Theme.of(context).primaryColor);
    });
  }

  void updatePrimarySwatch(MaterialColor primarySwatch) {
    setState(() {
      _primarySwatch = primarySwatch;
    });
  }

  void updateAccentColor(MaterialAccentColor accentColor) {
    setState(() {
      _accentColor = accentColor;
    });
  }
}
