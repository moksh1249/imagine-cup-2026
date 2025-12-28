import 'package:flutter/material.dart';
import 'package:study_buddy/router.dart';
import 'package:study_buddy/services/user_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize UserService
  final userService = UserService();
  await userService.initialize();
  
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
      debugShowCheckedModeBanner: false,
    );
  }
}
