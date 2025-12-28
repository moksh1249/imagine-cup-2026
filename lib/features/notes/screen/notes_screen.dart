import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  String selectedTab = 'Summary';
  final List<String> tabs = ['Summary', 'Key Points', 'Formulas'];

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
          'Smart Notes',
          style: TextStyle(
            color: Color(0xFF130e1b),
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lexend',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Course header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Physics 101 - Lecture 1',
                    style: TextStyle(
                      color: Color(0xFF130e1b),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Lexend',
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Introduction to Motion',
                    style: TextStyle(
                      color: Color(0xFF6b7280),
                      fontSize: 14,
                      fontFamily: 'Lexend',
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.access_time,
                        color: Colors.grey[400],
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '45 minutes',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 12,
                          fontFamily: 'Lexend',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Tab navigation
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: tabs.map((tab) {
                    final isSelected = selectedTab == tab;
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTab = tab;
                          });
                        },
                        child: Column(
                          children: [
                            Text(
                              tab,
                              style: TextStyle(
                                color: isSelected
                                    ? const Color(0xFF7e37f1)
                                    : const Color(0xFF6b7280),
                                fontSize: 14,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                fontFamily: 'Lexend',
                              ),
                            ),
                            if (isSelected)
                              Container(
                                margin: const EdgeInsets.only(top: 8),
                                height: 3,
                                width: 20,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF7e37f1),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Tab content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (selectedTab == 'Summary') ...[
                    const Text(
                      'Lecture Summary',
                      style: TextStyle(
                        color: Color(0xFF130e1b),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lexend',
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'This lecture introduces fundamental concepts in classical mechanics. We covered displacement, velocity, and acceleration, which are essential for understanding motion. These concepts form the foundation for Newton\'s laws and advanced physics topics.',
                      style: TextStyle(
                        color: Color(0xFF6b7280),
                        fontSize: 14,
                        fontFamily: 'Lexend',
                        height: 1.6,
                      ),
                    ),
                  ] else if (selectedTab == 'Key Points') ...[
                    const Text(
                      'Key Points',
                      style: TextStyle(
                        color: Color(0xFF130e1b),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lexend',
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildKeyPoint(
                      'Displacement vs Distance',
                      'Displacement is the change in position, while distance is the total path traveled.',
                    ),
                    const SizedBox(height: 12),
                    _buildKeyPoint(
                      'Average Velocity',
                      'Velocity is the rate of change of displacement with respect to time.',
                    ),
                    const SizedBox(height: 12),
                    _buildKeyPoint(
                      'Acceleration',
                      'Acceleration is the rate of change of velocity over time.',
                    ),
                  ] else if (selectedTab == 'Formulas') ...[
                    const Text(
                      'Important Formulas',
                      style: TextStyle(
                        color: Color(0xFF130e1b),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lexend',
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildFormula(
                      'Velocity',
                      'v = Δd / Δt',
                      'Change in distance / Change in time',
                    ),
                    const SizedBox(height: 12),
                    _buildFormula(
                      'Acceleration',
                      'a = Δv / Δt',
                      'Change in velocity / Change in time',
                    ),
                    const SizedBox(height: 12),
                    _buildFormula(
                      'Distance',
                      'd = v × t',
                      'Velocity × Time (constant velocity)',
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildKeyPoint(String title, String description) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF7e37f1).withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF7e37f1).withOpacity(0.2),
          width: 1,
        ),
      ),
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
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormula(String name, String formula, String explanation) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey[200]!,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              color: Color(0xFF130e1b),
              fontSize: 12,
              fontWeight: FontWeight.bold,
              fontFamily: 'Lexend',
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF7e37f1).withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              formula,
              style: const TextStyle(
                color: Color(0xFF7e37f1),
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: 'Lexend',
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            explanation,
            style: const TextStyle(
              color: Color(0xFF6b7280),
              fontSize: 11,
              fontFamily: 'Lexend',
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
