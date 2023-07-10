import 'package:flutter/material.dart';

class LocalizationProvider extends ChangeNotifier {
  Locale _locale = Locale('en');

  Locale get locale => _locale;

  set locale(Locale locale) {
    if (_locale != locale) {
      _locale = locale;
      notifyListeners();
    }
  }
}
