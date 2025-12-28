import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class QuizQuestionScreen extends StatefulWidget {
  const QuizQuestionScreen({super.key});

  @override
  State<QuizQuestionScreen> createState() => _QuizQuestionScreenState();
}

class _QuizQuestionScreenState extends State<QuizQuestionScreen> {
  int currentQuestion = 1;
  int totalQuestions = 10;
  String? selectedAnswer;

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
      ),
      body: Column(
        children: [
          // Progress
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Question $currentQuestion of $totalQuestions',
                      style: const TextStyle(
                        color: Color(0xFF6b7280),
                        fontSize: 14,
                        fontFamily: 'Lexend',
                      ),
                    ),
                    Text(
                      '${((currentQuestion / totalQuestions) * 100).toStringAsFixed(0)}%',
                      style: const TextStyle(
                        color: Color(0xFF7e37f1),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lexend',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: currentQuestion / totalQuestions,
                    minHeight: 8,
                    backgroundColor: Colors.grey[200],
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF7e37f1),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Question content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    const Text(
                      'Which of the following correctly describes velocity?',
                      style: TextStyle(
                        color: Color(0xFF130e1b),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lexend',
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Answer options
                    _buildAnswerOption(
                      'A',
                      'The total distance traveled by an object',
                      'A' == selectedAnswer,
                      () {
                        setState(() => selectedAnswer = 'A');
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildAnswerOption(
                      'B',
                      'The rate of change of displacement with respect to time',
                      'B' == selectedAnswer,
                      () {
                        setState(() => selectedAnswer = 'B');
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildAnswerOption(
                      'C',
                      'The speed of an object at a specific instant',
                      'C' == selectedAnswer,
                      () {
                        setState(() => selectedAnswer = 'C');
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildAnswerOption(
                      'D',
                      'The acceleration of an object over time',
                      'D' == selectedAnswer,
                      () {
                        setState(() => selectedAnswer = 'D');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Action buttons
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
                  disabledBackgroundColor: Colors.grey[300],
                ),
                onPressed: selectedAnswer != null
                    ? () {
                        context.push('/quiz-feedback-correct');
                      }
                    : null,
                child: const Text(
                  'Submit Answer',
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
    );
  }

  Widget _buildAnswerOption(
    String letter,
    String text,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF7e37f1).withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF7e37f1)
                : Colors.grey[200]!,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF7e37f1)
                    : Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  letter,
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : const Color(0xFF6b7280),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lexend',
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: const Color(0xFF130e1b),
                  fontSize: 14,
                  fontFamily: 'Lexend',
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
