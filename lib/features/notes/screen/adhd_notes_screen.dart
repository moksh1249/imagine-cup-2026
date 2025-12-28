import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ADHDNotesScreen extends StatelessWidget {
  const ADHDNotesScreen({super.key});

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
          'ADHD-Friendly Notes',
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
                  color: const Color(0xFF10B981).withOpacity(0.1),
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
                      'Clear, concise summary with minimal distractions',
                      style: TextStyle(
                        color: Color(0xFF6b7280),
                        fontSize: 13,
                        fontFamily: 'Lexend',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Content cards
              _buildContentCard(
                '🎯',
                'Main Idea',
                'Objects move, change speed, and change direction. We measure these changes.',
                const Color(0xFF10B981),
              ),
              const SizedBox(height: 16),
              _buildContentCard(
                '📝',
                '3 Key Terms',
                '1. Displacement - position change\n2. Velocity - speed with direction\n3. Acceleration - speed change',
                const Color(0xFF7e37f1),
              ),
              const SizedBox(height: 16),
              _buildContentCard(
                '⚡',
                'Important Formula',
                'Velocity = Distance ÷ Time',
                const Color(0xFFF59E0B),
              ),
              const SizedBox(height: 16),
              _buildContentCard(
                '💡',
                'Real-World Example',
                'A car going 60 km/h for 2 hours travels 120 km.',
                const Color(0xFF3B82F6),
              ),
              const SizedBox(height: 32),
              // Quick review section
              const Text(
                'What to Remember',
                style: TextStyle(
                  color: Color(0xFF130e1b),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lexend',
                ),
              ),
              const SizedBox(height: 12),
              _buildChecklist(
                'Velocity requires both speed AND direction',
              ),
              const SizedBox(height: 8),
              _buildChecklist(
                'Acceleration happens when speed changes',
              ),
              const SizedBox(height: 8),
              _buildChecklist(
                'Time matters for all calculations',
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContentCard(
    String icon,
    String title,
    String content,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                icon,
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lexend',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              color: Color(0xFF6b7280),
              fontSize: 14,
              fontFamily: 'Lexend',
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChecklist(String item) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: const BoxDecoration(
            color: Color(0xFF10B981),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check,
            color: Colors.white,
            size: 14,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            item,
            style: const TextStyle(
              color: Color(0xFF6b7280),
              fontSize: 14,
              fontFamily: 'Lexend',
            ),
          ),
        ),
      ],
    );
  }
}
