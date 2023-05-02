import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Storage Manager/storage_manager.dart';
import 'Color.dart';

class ThemeNotifier with ChangeNotifier {
  static final darkTheme = ThemeData(
    primaryColor: Colors.white,
    brightness: Brightness.dark,
    secondaryHeaderColor: const Color(0xfff2fafe),
    canvasColor: Colors.transparent,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xff1f1f1f), unselectedItemColor: Colors.white),
    cardTheme: const CardTheme(
      color: Color(0xff0f0f0f),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    primaryIconTheme: const IconThemeData(color: Colors.white),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color(0xff0f0f0f),
    ),
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.poppins(
        color: Colors.white,
      ),
      bodyMedium: GoogleFonts.poppins(
        color: Colors.white,
      ),
      bodySmall: GoogleFonts.poppins(
        color: Colors.white70,
      ),
    ),
    dividerColor: Colors.white70,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff262626),
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      scrolledUnderElevation: 0,
    ),
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xff2a2a2a),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.blue,
      brightness: Brightness.dark,
    ).copyWith(
        background: const Color(
      0xff101010,
    )),
  );

  final lightTheme = ThemeData(
    primaryColor: Colors.black,
    brightness: Brightness.light,
    secondaryHeaderColor: const Color(0xfff2fafe),
    canvasColor: Colors.transparent,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white, unselectedItemColor: Colors.black87),
    cardTheme: const CardTheme(color: Color(0xffffffff)),
    iconTheme: const IconThemeData(color: Colors.black87),
    primaryIconTheme: const IconThemeData(color: Colors.white),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color(0xffffffff),
    ),
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.poppins(
        color: Colors.black,
      ),
      bodyMedium: GoogleFonts.poppins(
        color: Colors.black,
      ),
      bodySmall: GoogleFonts.poppins(
        color: Colors.black54,
      ),
    ),
    dividerColor: Colors.grey.shade400,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorCollections.appColor,
      elevation: 0,
      shadowColor: Colors.grey.shade600,
      iconTheme: const IconThemeData(color: Colors.black),
      scrolledUnderElevation: 0,
    ),
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.blue,
      brightness: Brightness.light,
    ).copyWith(
      background: Colors.white,
    ),
  );

  ThemeData _themeData = ThemeData.light();
  ThemeData getTheme() => _themeData;

  ThemeNotifier() {
    StorageManager.readData('themeMode').then((value) {
      var themeMode = value ?? 'light';
      if (themeMode == 'light') {
        _themeData = lightTheme;
      } else {
        _themeData = darkTheme;
      }
      notifyListeners();
    });
  }

  void setDarkMode() async {
    _themeData = darkTheme;
    StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme;
    StorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }

  changeTheme() {
    if (_themeData == darkTheme) {
      _themeData = lightTheme;
      StorageManager.saveData('themeMode', 'light');
    } else {
      _themeData = darkTheme;
      StorageManager.saveData('themeMode', 'dark');
    }
    notifyListeners();
  }
}
