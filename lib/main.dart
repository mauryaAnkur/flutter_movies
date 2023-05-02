import 'package:flutter/material.dart';
import 'package:flutter_movies/Screens/home_screen.dart';
import 'package:provider/provider.dart';

import 'Color/theme_manager.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (BuildContext context) => ThemeNotifier(),
          ),
        ],
        child: Consumer<ThemeNotifier>(
          builder: (context, theme, child) => MaterialApp(
            title: 'Movies',
            debugShowCheckedModeBanner: false,
            theme: theme.getTheme(),
            home: const HomeScreen(),
          ),
        ));
  }
}

