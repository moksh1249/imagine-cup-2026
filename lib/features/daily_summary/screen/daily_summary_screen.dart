import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DailySummaryScreen extends StatelessWidget {
  const DailySummaryScreen({super.key});

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
          'Today\'s Summary',
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
              // Date
              Text(
                'December 29, 2025',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                  fontFamily: 'Lexend',
                ),
              ),
              const SizedBox(height: 24),
              // Overall stats
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF7e37f1),
                      Color(0xFF6b32cc),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Study Session',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontFamily: 'Lexend',
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Total Time',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                                fontFamily: 'Lexend',
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              '2h 45m',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Lexend',
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Streak',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                                fontFamily: 'Lexend',
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              '5 days',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Lexend',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // Activities
              const Text(
                'Today\'s Activities',
                style: TextStyle(
                  color: Color(0xFF130e1b),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lexend',
                ),
              ),
              const SizedBox(height: 16),
              _buildActivityItem(
                '📚',
                'Lectures Studied',
                '3',
                'Physics, Chemistry, Math',
              ),
              const SizedBox(height: 12),
              _buildActivityItem(
                '✍️',
                'Notes Created',
                '12',
                'AI-generated summaries',
              ),
              const SizedBox(height: 12),
              _buildActivityItem(
                '🔄',
                'Flashcards Reviewed',
                '45',
                'From 5 different decks',
              ),
              const SizedBox(height: 12),
              _buildActivityItem(
                '❓',
                'Quiz Questions',
                '10',
                '8 correct - 80%',
              ),
              const SizedBox(height: 32),
              // Performance metrics
              const Text(
                'Performance',
                style: TextStyle(
                  color: Color(0xFF130e1b),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lexend',
                ),
              ),
              const SizedBox(height: 16),
              _buildMetricBar('Accuracy', 80),
              const SizedBox(height: 12),
              _buildMetricBar('Retention', 72),
              const SizedBox(height: 12),
              _buildMetricBar('Consistency', 95),
              const SizedBox(height: 32),
              // Achievements
              const Text(
                'Achievements Unlocked',
                style: TextStyle(
                  color: Color(0xFF130e1b),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lexend',
                ),
              ),
              const SizedBox(height: 16),
              _buildAchievementBadge('🔥', '5-Day Streak', 'Study for 5 consecutive days'),
              const SizedBox(height: 12),
              _buildAchievementBadge('🎯', '80% Accuracy', 'Achieve 80% on a quiz'),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityItem(
    String icon,
    String title,
    String value,
    String description,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            icon,
            style: const TextStyle(fontSize: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF130e1b),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lexend',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: Color(0xFF6b7280),
                    fontSize: 12,
                    fontFamily: 'Lexend',
                  ),
                ),
              ],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF7e37f1),
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Lexend',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricBar(String label, int value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
              '$value%',
              style: const TextStyle(
                color: Color(0xFF7e37f1),
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: 'Lexend',
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: value / 100,
            minHeight: 8,
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation<Color>(
              Color(0xFF7e37f1),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementBadge(String icon, String title, String description) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF10B981).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF10B981).withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Text(
            icon,
            style: const TextStyle(fontSize: 28),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF130e1b),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lexend',
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: const TextStyle(
                    color: Color(0xFF6b7280),
                    fontSize: 12,
                    fontFamily: 'Lexend',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
