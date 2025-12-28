import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class QuizFeedbackCorrectScreen extends StatelessWidget {
  const QuizFeedbackCorrectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Success animation
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
                size: 64,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Correct!',
              style: TextStyle(
                color: Color(0xFF130e1b),
                fontSize: 32,
                fontWeight: FontWeight.bold,
                fontFamily: 'Lexend',
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Great job! You got it right.',
              style: TextStyle(
                color: Color(0xFF6b7280),
                fontSize: 16,
                fontFamily: 'Lexend',
              ),
            ),
            const SizedBox(height: 32),
            // Explanation
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFF10B981).withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Explanation',
                      style: TextStyle(
                        color: Color(0xFF130e1b),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lexend',
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Velocity is defined as the rate of change of displacement with respect to time. It is a vector quantity that includes both magnitude and direction.',
                      style: TextStyle(
                        color: Color(0xFF6b7280),
                        fontSize: 13,
                        fontFamily: 'Lexend',
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            // Button
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
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
                    context.push('/quiz-question');
                  },
                  child: const Text(
                    'Next Question',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Lexend',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
