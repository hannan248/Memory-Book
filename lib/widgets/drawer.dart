import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Memory Book',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 90,
            ),
            ListTile(
              title: ElevatedButton(
                onPressed: () {
                  // Toggle the theme using AdaptiveTheme
                  AdaptiveTheme.of(context).toggleThemeMode();
                },
                child: const Text(
                  'Dark Mode',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
