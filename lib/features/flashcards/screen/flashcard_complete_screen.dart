import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FlashcardCompleteScreen extends StatelessWidget {
  const FlashcardCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Success Icon
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle,
              color: Color(0xFF10B981),
              size: 80,
            ),
          ),
          const SizedBox(height: 32),
          // Title
          const Text(
            'Great Job!',
            style: TextStyle(
              color: Color(0xFF130e1b),
              fontSize: 32,
              fontWeight: FontWeight.bold,
              fontFamily: 'Lexend',
            ),
          ),
          const SizedBox(height: 12),
          // Subtitle
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'You have completed all flashcards in this deck',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF6b7280),
                fontSize: 16,
                fontFamily: 'Lexend',
              ),
            ),
          ),
          const SizedBox(height: 48),
          // Stats
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Column(
              children: [
                _buildStatRow('Cards Reviewed', '24'),
                const SizedBox(height: 12),
                _buildStatRow('Correct', '18'),
                const SizedBox(height: 12),
                _buildStatRow('Need Review', '6'),
                const SizedBox(height: 12),
                _buildStatRow('Success Rate', '75%'),
              ],
            ),
          ),
          const SizedBox(height: 48),
          // Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
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
                      'Back to Home',
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
                      context.go('/flashcards-dashboard');
                    },
                    child: const Text(
                      'View Another Deck',
                      style: TextStyle(
                        color: Color(0xFF7e37f1),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lexend',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF6b7280),
            fontSize: 14,
            fontFamily: 'Lexend',
          ),
        ),
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
    );
  }
}
