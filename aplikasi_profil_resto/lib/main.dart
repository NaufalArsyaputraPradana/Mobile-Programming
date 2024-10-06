import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          SafeArea(
            child: Scaffold(
              backgroundColor: pageBgColor,
              appBar: AppBar(
                backgroundColor: headerBackColor,
                title: const Text(
                  "Kuliner Nusantara",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
              ),
              body: const HomePage(),
            ),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Contoh implementasi sederhana dari HomePage
    return Center(
      child: Text('Welcome to Kuliner Nusantara!'),
    );
  }
}
