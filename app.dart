import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/report_form_screen.dart';

class SkinScreeningApp extends StatelessWidget {
  const SkinScreeningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Skin Condition Screening System',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF167D68),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5FAF8),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/report': (context) => const ReportFormScreen(),
      },
    );
  }
}