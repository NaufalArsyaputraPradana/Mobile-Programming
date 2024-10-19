import 'package:flutter/material.dart';
import 'home_page.dart';
import 'styles.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hilangkan banner debug
      home: SafeArea(
        child: Scaffold(
          backgroundColor: pageBgColor,
          appBar: AppBar(
            backgroundColor: headerBackColor,
            title: Text(
              "Kuliner Nusantara",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: pageBgColor,
              ),
            ),
            centerTitle: true,
          ),
          body: const HomePage(),
        ),
      ),
    );
  }
}
