import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileResultScreen extends StatelessWidget {
  const ProfileResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                // Success badge
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: Color(0xFF10B981),
                    size: 60,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Profile Complete!',
                  style: TextStyle(
                    color: Color(0xFF130e1b),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lexend',
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'We now know how you learn best',
                  style: TextStyle(
                    color: Color(0xFF6b7280),
                    fontSize: 16,
                    fontFamily: 'Lexend',
                  ),
                ),
                const SizedBox(height: 32),
                // Profile summary
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Your Learning Profile',
                        style: TextStyle(
                          color: Color(0xFF130e1b),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Lexend',
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildProfileItem(
                        'Reading Style',
                        'Visual Learner',
                        const Color(0xFF7e37f1),
                      ),
                      const SizedBox(height: 16),
                      _buildProfileItem(
                        'Focus Duration',
                        '45 minutes optimal',
                        const Color(0xFF10B981),
                      ),
                      const SizedBox(height: 16),
                      _buildProfileItem(
                        'Break Preference',
                        '15 minute breaks',
                        const Color(0xFFF59E0B),
                      ),
                      const SizedBox(height: 16),
                      _buildProfileItem(
                        'Accessibility',
                        'Dyslexia mode enabled',
                        const Color(0xFF3B82F6),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                // Recommendations
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF7e37f1).withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFF7e37f1).withOpacity(0.2),
                    ),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Personalized Recommendations',
                        style: TextStyle(
                          color: Color(0xFF130e1b),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Lexend',
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        '✓ Use visual-heavy study materials\n✓ Take breaks every 45 minutes\n✓ Enable focus mode during study sessions\n✓ Use flashcards for quick review',
                        style: TextStyle(
                          color: Color(0xFF6b7280),
                          fontSize: 13,
                          fontFamily: 'Lexend',
                          height: 1.8,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                // Action buttons
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7e37f1),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      context.go('/home');
                    },
                    child: const Text(
                      'Start Learning',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lexend',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(
                        color: Color(0xFF7e37f1),
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      context.push('/settings');
                    },
                    child: const Text(
                      'Adjust Settings',
                      style: TextStyle(
                        color: Color(0xFF7e37f1),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lexend',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileItem(String label, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF6b7280),
                fontSize: 12,
                fontFamily: 'Lexend',
              ),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                color: Color(0xFF130e1b),
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Lexend',
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.check, color: color, size: 20),
        ),
      ],
    );
  }
}
