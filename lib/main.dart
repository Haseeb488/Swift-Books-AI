import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swiftbook_ai/login_page.dart';
import 'package:swiftbook_ai/theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required before using async in main
  await loadThemeFromPrefs(); // Load saved theme
  runApp(MyApp());
}

// Global notifier to toggle theme
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.dark);

// Key for SharedPreferences
const String themePrefKey = 'theme_mode';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentTheme, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: currentTheme,
          theme: lightTheme,
          darkTheme: darkTheme,
          home: LoginPage(),
        );
      },
    );
  }
}

Future<void> loadThemeFromPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  final themeString = prefs.getString(themePrefKey) ?? 'dark';
  themeNotifier.value = getThemeModeFromString(themeString);
}


// Convert string back to ThemeMode
ThemeMode getThemeModeFromString(String mode) {
  switch (mode) {
    case 'light':
      return ThemeMode.light;
    case 'dark':
      return ThemeMode.dark;
    case 'system':
    default:
      return ThemeMode.system;
  }
}

