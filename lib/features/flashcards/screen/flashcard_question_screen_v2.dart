import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FlashcardQuestionScreenV2 extends StatefulWidget {
  const FlashcardQuestionScreenV2({super.key});

  @override
  State<FlashcardQuestionScreenV2> createState() =>
      _FlashcardQuestionScreenV2State();
}

class _FlashcardQuestionScreenV2State extends State<FlashcardQuestionScreenV2>
    with TickerProviderStateMixin {
  bool _isRevealed = false;
  late AnimationController _flipAnimationController;
  late AnimationController _transitionAnimationController;
  late Animation<double> _flipAnimation;
  late Animation<double> _fadeOutAnimation;
  late Animation<double> _scaleAnimation;

  // Sample flashcard data
  final List<Map<String, String>> flashcards = [
    {
      'question': 'What is the formula for calculating velocity?',
      'answer': 'Velocity = Distance / Time\n\nor v = d/t',
      'explanation': 'Velocity is the rate of change of displacement with respect to time.'
    },
    {
      'question': 'What are the three states of matter?',
      'answer': 'Solid, Liquid, and Gas',
      'explanation': 'These are the most common states of matter that we observe in nature.'
    },
    {
      'question': 'What is photosynthesis?',
      'answer': '6CO₂ + 6H₂O + light → C₆H₁₂O₆ + 6O₂',
      'explanation': 'The process by which plants convert light energy into chemical energy.'
    },
  ];

  int _currentCardIndex = 0;
  bool _isTransitioning = false;

  @override
  void initState() {
    super.initState();
    _flipAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _flipAnimationController, curve: Curves.easeInOut),
    );

    // Transition animation controller
    _transitionAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    _fadeOutAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _transitionAnimationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.8).animate(
      CurvedAnimation(
        parent: _transitionAnimationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );
  }

  @override
  void dispose() {
    _flipAnimationController.dispose();
    _transitionAnimationController.dispose();
    super.dispose();
  }

  void _revealCard() {
    if (!_isRevealed) {
      _flipAnimationController.forward();
      setState(() {
        _isRevealed = true;
      });
    }
  }

  Future<void> _nextCard(String response) async {
    if (_isTransitioning) return; // Prevent multiple transitions

    setState(() {
      _isTransitioning = true;
    });

    // Start fade out and scale animation
    await _transitionAnimationController.forward();

    if (_currentCardIndex < flashcards.length - 1) {
      // Move to next card
      setState(() {
        _currentCardIndex++;
        _isRevealed = false;
      });
      // Reset animations for next card
      _transitionAnimationController.reset();
      _flipAnimationController.reset();
      _isTransitioning = false;
    } else {
      // All cards completed - animate to completion screen
      await _animateCompletion();
    }
  }

  Future<void> _animateCompletion() async {
    // Add a brief delay for completion effect
    await Future.delayed(const Duration(milliseconds: 300));
    
    if (mounted) {
      // Navigate to completion screen with fade transition
      context.go('/flashcard-complete');
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentCard = flashcards[_currentCardIndex];
    final totalCards = flashcards.length;

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
                      'Card ${_currentCardIndex + 1} of $totalCards',
                      style: const TextStyle(
                        color: Color(0xFF6b7280),
                        fontSize: 14,
                        fontFamily: 'Lexend',
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.favorite_border,
                            color: Colors.grey[400]),
                        const SizedBox(width: 12),
                        Icon(Icons.bookmark_border,
                            color: Colors.grey[400]),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: (_currentCardIndex + 1) / totalCards,
                    minHeight: 8,
                    backgroundColor: const Color(0xFFE5E7EB),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF7e37f1),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Card Container (Question/Answer) with transition animation
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: AnimatedBuilder(
                  animation: _transitionAnimationController,
                  builder: (context, child) {
                    return Opacity(
                      opacity: 1.0 - _fadeOutAnimation.value,
                      child: Transform.scale(
                        scale: 1.0 - (_scaleAnimation.value - 0.8),
                        child: GestureDetector(
                          onTap: _revealCard,
                          child: AnimatedBuilder(
                            animation: _flipAnimation,
                            builder: (context, child) {
                              final angle = _flipAnimation.value * 3.14159265359;
                              final isBack = _flipAnimation.value > 0.5;

                              return Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()
                                  ..setEntry(3, 2, 0.001)
                                  ..rotateY(angle),
                                child: isBack
                                    ? _buildAnswerCard(currentCard)
                                    : _buildQuestionCard(currentCard),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          // Response buttons (only show when revealed)
          if (_isRevealed && !_isTransitioning)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    'How well did you know this?',
                    style: TextStyle(
                      color: Color(0xFF6b7280),
                      fontSize: 14,
                      fontFamily: 'Lexend',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildResponseButton(
                        'Again',
                        const Color(0xFFEF4444),
                        onTap: () => _nextCard('again'),
                      ),
                      const SizedBox(width: 12),
                      _buildResponseButton(
                        'Hard',
                        const Color(0xFFF59E0B),
                        onTap: () => _nextCard('hard'),
                      ),
                      const SizedBox(width: 12),
                      _buildResponseButton(
                        'Good',
                        const Color(0xFF3B82F6),
                        onTap: () => _nextCard('good'),
                      ),
                      const SizedBox(width: 12),
                      _buildResponseButton(
                        'Easy',
                        const Color(0xFF10B981),
                        onTap: () => _nextCard('easy'),
                      ),
                    ],
                  ),
                ],
              ),
            )
          else if (_isTransitioning)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                    child: Center(
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF7e37f1),
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(2.0),
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Color(0xFF7e37f1),
                            ),
                            strokeWidth: 3,
                          ),
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

  Widget _buildQuestionCard(Map<String, String> card) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF7e37f1),
            Color(0xFF6b32cc),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7e37f1).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'QUESTION',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              fontFamily: 'Lexend',
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              card['question']!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontFamily: 'Lexend',
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 48),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1.5,
              ),
            ),
            child: const Text(
              'Tap to reveal answer',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Lexend',
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerCard(Map<String, String> card) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF10B981),
            Color(0xFF059669),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF10B981).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'ANSWER',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                fontFamily: 'Lexend',
                letterSpacing: 1,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              card['answer']!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
                fontFamily: 'Lexend',
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1.5,
              ),
            ),
            child: Text(
              card['explanation']!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 13,
                fontFamily: 'Lexend',
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResponseButton(
    String label,
    Color color, {
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: color,
              width: 2,
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color,
              fontSize: 13,
              fontWeight: FontWeight.bold,
              fontFamily: 'Lexend',
            ),
          ),
        ),
      ),
    );
  }
}
