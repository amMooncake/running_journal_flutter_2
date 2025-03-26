import 'package:flutter/material.dart';
import 'package:running_journal_flutter_2/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    const white = Color.fromARGB(255, 255, 255, 255);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          bodySmall: TextStyle(fontSize: 13, color: white, fontWeight: FontWeight.w300),
          bodyMedium: TextStyle(fontSize: 18, color: white, fontWeight: FontWeight.w500),
          bodyLarge: TextStyle(fontSize: 30, color: white, fontWeight: FontWeight.w800),
        ),
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: const Color(0xFF2196F3),
          onSurface: white,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
