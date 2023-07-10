import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_movies/Screens/home_screen.dart';
import 'package:flutter_movies/test_screen.dart';
import 'package:provider/provider.dart';

import 'Color/theme_manager.dart';
import 'package:provider/provider.dart';

import 'language/localization.dart';

// void main() async {
//   runApp(const MyApp());
// }

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => LocalizationProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<LocalizationProvider>(
      builder: (context, provider, child) {
        return MaterialApp(
          title: 'My App',
          theme: ThemeData(primarySwatch: Colors.blue),
          locale: provider.locale,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en', ''),
            const Locale('es', ''),
          ],
          home: HomeScreen(),
        );
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          localization?.translate('title') ?? '',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>
              SettingsScreen()));
            },
            icon: Icon(
              Icons.settings,
              size: 26,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Text(
            localization?.translate('welcome_message') ?? 'not',
            style: TextStyle(
              color: Colors.black,
              fontSize: 45,
            ),
          ),

          // SettingsScreen(),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocalizationProvider>(context);

    return Scaffold(
      body: Center(
        child: DropdownButton<Locale>(
          value: provider.locale,
          onChanged: (Locale? newLocale) {
            if (newLocale != null) {
              provider.locale = newLocale;
            }
          },
          items: const [
            DropdownMenuItem(
              value: Locale('en', ''),
              child: Text('English'),
            ),
            DropdownMenuItem(
              value: Locale('es', ''),
              child: Text('Español'),
            ),
          ],
        ),
      ),
    );
  }
}



class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
  _AppLocalizationsDelegate();

  late Map<String, String> _localizedStrings;

  Future<bool> load() async {
    String jsonString =
    await rootBundle.loadString('assets/language/${locale.languageCode}.json');

    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  String? translate(String key) {
    return _localizedStrings[key];
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'es'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}





