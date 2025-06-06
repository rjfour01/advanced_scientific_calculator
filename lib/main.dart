import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('calculation_history');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = false;

  void toggleTheme() {
    setState(() {
      isDark = !isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scientific Calculator',
      theme: isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
      home: HomeScreen(onToggleTheme: toggleTheme, isDark: isDark),
      debugShowCheckedModeBanner: false,
    );
  }
}

// This file now contains your custom app entry point for the calculator.
// All logic and UI are as per your requirements.
