import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DyslexiaNotesScreen extends StatelessWidget {
  const DyslexiaNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF130e1b)),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Dyslexia-Friendly Notes',
          style: TextStyle(
            color: Color(0xFF130e1b),
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lexend',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF7e37f1).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Physics 101 - Lecture 1',
                      style: TextStyle(
                        color: Color(0xFF130e1b),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lexend',
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Optimized for easy reading with larger fonts and increased spacing',
                      style: TextStyle(
                        color: Color(0xFF6b7280),
                        fontSize: 13,
                        fontFamily: 'Lexend',
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Main content with accessibility features
              const Text(
                'Key Concepts',
                style: TextStyle(
                  color: Color(0xFF130e1b),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lexend',
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 20),
              _buildAccessibleSection(
                '1. Displacement',
                'The change in position of an object from its starting point to its ending point.',
                const Color(0xFF7e37f1),
              ),
              const SizedBox(height: 20),
              _buildAccessibleSection(
                '2. Velocity',
                'How fast something is moving in a specific direction. Formula: v = distance ÷ time',
                const Color(0xFF10B981),
              ),
              const SizedBox(height: 20),
              _buildAccessibleSection(
                '3. Acceleration',
                'How quickly an object speeds up, slows down, or changes direction.',
                const Color(0xFFF59E0B),
              ),
              const SizedBox(height: 32),
              // Summary box
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey[300]!,
                    width: 2,
                  ),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quick Summary',
                      style: TextStyle(
                        color: Color(0xFF130e1b),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lexend',
                        letterSpacing: 0.3,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'This lecture introduces the basic ideas about motion.\n\n'
                      '• Objects change position (displacement)\n'
                      '• Speed tells us how fast (velocity)\n'
                      '• Acceleration means speeding up or slowing down\n\n'
                      'These ideas help us understand how things move in the world.',
                      style: TextStyle(
                        color: Color(0xFF6b7280),
                        fontSize: 15,
                        fontFamily: 'Lexend',
                        height: 2.0,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccessibleSection(String title, String content, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Lexend',
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              color: Color(0xFF6b7280),
              fontSize: 15,
              fontFamily: 'Lexend',
              height: 1.8,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}
