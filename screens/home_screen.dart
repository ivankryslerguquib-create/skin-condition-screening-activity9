import 'package:flutter/material.dart';
import '../widgets/app_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skin Screening System'),
        backgroundColor: const Color(0xFF167D68),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Login',
            icon: const Icon(Icons.login),
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 650),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.health_and_safety,
                  size: 90,
                  color: Color(0xFF167D68),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Skin Condition Screening System',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF17594D),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'A preliminary screening project that aims to '
                  'support the review of skin concerns using image '
                  'analysis and user-reported symptoms.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, height: 1.6),
                ),
                const SizedBox(height: 28),
                AppButton(
                  label: 'Open Report Form',
                  icon: Icons.assignment_outlined,
                  onPressed: () {
                    Navigator.pushNamed(context, '/report');
                  },
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  icon: const Icon(Icons.login),
                  label: const Text('Go to Login'),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Educational prototype only. This application '
                  'does not provide a confirmed medical diagnosis.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}