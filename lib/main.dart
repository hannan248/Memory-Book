import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:memory_book/screen/home.dart';



void main() {
  runApp(const MyApp());
}

  class MyApp extends StatelessWidget {
  const MyApp({super.key,});

  @override
  Widget build(BuildContext context) {
  return AdaptiveTheme(
  light: ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
  useMaterial3: true,
  ),
  dark: ThemeData.dark(),
  initial: AdaptiveThemeMode.light, // Set the initial theme mode here
  builder: (theme, darkTheme) => MaterialApp(
    debugShowCheckedModeBanner: false,
  title: 'Memory Book',
  theme: theme,
  home: const Home(),
  ),
  );
  }
  }


