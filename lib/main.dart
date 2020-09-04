import 'package:flutter/material.dart';
import 'package:pin/data/data.dart';
import 'package:pin/screens/favourite.dart';
import 'package:pin/screens/homescreen.dart';
import 'package:pin/screens/setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  Color _color = Colors.white;

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
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(_color),
        '/favourite': (context) => Favourite(),
        '/setting': (context) => SettingsScreen(
            updateBrightness, updatePrimarySwatch, updateAccentColor, updatecolor),
      },
    );
  }

  void updateBrightness(Brightness brightness) {
    setState(() {
      _brightness = brightness;
    });
  }

  void updatecolor(Color color) {
    setState(() {
      _color = color;
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
