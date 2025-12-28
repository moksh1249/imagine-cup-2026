import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TranscriptScreen extends StatelessWidget {
  const TranscriptScreen({super.key});

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
          'Transcript',
          style: TextStyle(
            color: Color(0xFF130e1b),
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lexend',
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              icon: const Icon(Icons.search, color: Color(0xFF130e1b)),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header info
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF7e37f1).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Physics 101 - Lecture 1',
                          style: TextStyle(
                            color: Color(0xFF130e1b),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Lexend',
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          '45 minutes • Generated with AI',
                          style: TextStyle(
                            color: Color(0xFF6b7280),
                            fontSize: 12,
                            fontFamily: 'Lexend',
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.download, color: Color(0xFF7e37f1)),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Transcript text
              const Text(
                'Full Transcript',
                style: TextStyle(
                  color: Color(0xFF130e1b),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lexend',
                ),
              ),
              const SizedBox(height: 16),
              _buildTimestampedText(
                '00:00',
                'Welcome to Physics 101. Today we\'ll be exploring the fundamental concepts of classical mechanics, starting with displacement and velocity. These concepts form the foundation for understanding motion in our universe.',
              ),
              const SizedBox(height: 16),
              _buildTimestampedText(
                '02:30',
                'Displacement is defined as the change in position of an object. Unlike distance, which measures the total path traveled, displacement only cares about the starting and ending positions.',
              ),
              const SizedBox(height: 16),
              _buildTimestampedText(
                '05:45',
                'Velocity is the rate of change of displacement with respect to time. The formula is simple: velocity equals displacement divided by time. This gives us the average velocity over a time period.',
              ),
              const SizedBox(height: 16),
              _buildTimestampedText(
                '08:20',
                'Let\'s work through an example. If an object travels 100 meters in 10 seconds, the velocity would be 100 divided by 10, which equals 10 meters per second.',
              ),
              const SizedBox(height: 16),
              _buildTimestampedText(
                '11:00',
                'Acceleration is the rate of change of velocity. Just as velocity is the derivative of position, acceleration is the derivative of velocity. A = change in velocity / change in time.',
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimestampedText(String timestamp, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF7e37f1).withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            timestamp,
            style: const TextStyle(
              color: Color(0xFF7e37f1),
              fontSize: 12,
              fontWeight: FontWeight.bold,
              fontFamily: 'Lexend',
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFF6b7280),
              fontSize: 14,
              fontFamily: 'Lexend',
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}
