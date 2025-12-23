import 'package:flutter/material.dart';
import 'package:study_buddy/router.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'StudyBuddy',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Lexend',
      ),
    );
  }
}
