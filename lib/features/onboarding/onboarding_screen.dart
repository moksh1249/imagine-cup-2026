import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 3) {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    } else {
      context.go('/login');
    }
  }

  void _previousPage() {
    _pageController.animateToPage(
      _currentPage - 1,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
    );
  }

  void _skipOnboarding() {
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),
      body: Column(
        children: [
          // Fixed Header - Only shows on screens 2 and 3
          if (_currentPage > 0 && _currentPage < 3)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back,
                        color: Color(0xFF130e1b), size: 28),
                    onPressed: _previousPage,
                  ),
                  GestureDetector(
                    onTap: _skipOnboarding,
                    child: Text(
                      'Skip',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: const Color(0xFF7c3bed),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                    ),
                  ),
                ],
              ),
            )
          else if (_currentPage == 0)
            Padding(
              padding: const EdgeInsets.only(top: 48.0, right: 16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: _skipOnboarding,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Skip',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: const Color(0xFF4A4A4A),
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                    ),
                  ),
                ),
              ),
            ),
          // Swipeable Content Area
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                _buildContentScreen1(),
                _buildContentScreen2(),
                _buildContentScreen3(),
                _buildContentScreen4(),
              ],
            ),
          ),
          // Fixed Footer with Navigation
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            child: Column(
              children: [
                // Page Indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    4,
                    (index) {
                      if (index == _currentPage) {
                        return Container(
                          width: 32,
                          height: 12,
                          decoration: BoxDecoration(
                            color: const Color(0xFF7c3bed),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        );
                      } else {
                        return Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: const Color(0xFFCCCCCC),
                            shape: BoxShape.circle,
                          ),
                        );
                      }
                    },
                  ).expand((widget) {
                    return [widget, const SizedBox(width: 16)];
                  }).toList()
                    ..removeLast(),
                ),
                const SizedBox(height: 32),
                // Next/Get Started Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7c3bed),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      elevation: 8,
                      shadowColor: const Color(0xFF7c3bed).withOpacity(0.25),
                    ),
                    onPressed: _nextPage,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _currentPage == 3 ? 'Get Started' : 'Next',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                        ),
                        const SizedBox(width: 12),
                        const Icon(Icons.arrow_forward, color: Colors.white),
                      ],
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

  // Content Screen 1
  Widget _buildContentScreen1() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            // Illustration
            Container(
              width: 280,
              height: 210,
              decoration: BoxDecoration(
                color: const Color(0xFFFFFBF5),
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                  ),
                ],
                border: Border.all(
                  color: const Color(0xFF7c3bed).withOpacity(0.1),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Image.asset(
                  'assets/oi1.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: const Color(0xFFF5F3FF),
                      child: const Center(
                        child: Icon(
                          Icons.image_not_supported,
                          color: Color(0xFF7c3bed),
                          size: 48,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 48),
            // Title
            Text(
              'Upload any lecture',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: const Color(0xFF1F1F1F),
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // Subtitle
            Text(
              'Record or upload your class, we\'ll do the rest',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: const Color(0xFF4A4A4A),
                    fontSize: 18,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // Content Screen 2
  Widget _buildContentScreen2() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            // Illustration
            Container(
              width: 280,
              height: 210,
              decoration: BoxDecoration(
                color: const Color(0xFFFFFBF5),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                  ),
                ],
                border: Border.all(
                  color: const Color(0xFF7c3bed).withOpacity(0.1),
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.asset(
                      'assets/oi2.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(0xFFF5F3FF),
                          child: const Center(
                            child: Icon(
                              Icons.image_not_supported,
                              color: Color(0xFF7c3bed),
                              size: 48,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Decorative badge
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.auto_awesome,
                        color: Color(0xFF10B981),
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
            // Title
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'AI creates ',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: const Color(0xFF1F1F1F),
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                  ),
                  TextSpan(
                    text: 'smart notes',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: const Color(0xFF7c3bed),
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Subtitle
            Text(
              'Summaries, key points, formulas — all automatic.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: const Color(0xFF4A4A4A),
                    fontSize: 18,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // Content Screen 3
  Widget _buildContentScreen3() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            // Illustration
            Container(
              width: 280,
              height: 210,
              decoration: BoxDecoration(
                color: const Color(0xFFFFFBF5),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                  ),
                ],
                border: Border.all(
                  color: const Color(0xFF7c3bed).withOpacity(0.1),
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        colors: [
                          const Color(0xFF10B981).withOpacity(0.1),
                          const Color(0xFF7c3bed).withOpacity(0.05),
                        ],
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.asset(
                      'assets/oi3.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(0xFFF5F3FF),
                          child: const Center(
                            child: Icon(
                              Icons.image_not_supported,
                              color: Color(0xFF7c3bed),
                              size: 48,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
            // Title
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Made for how ',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: const Color(0xFF130e1b),
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                  ),
                  TextSpan(
                    text: 'YOU',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: const Color(0xFF7c3bed),
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                  ),
                  TextSpan(
                    text: ' learn',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: const Color(0xFF130e1b),
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Subtitle
            Text(
              'Special modes for ADHD, Dyslexia and more to help you focus.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: const Color(0xFF504a5c),
                    fontSize: 18,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // Content Screen 4
  Widget _buildContentScreen4() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            // Illustration
            Container(
              width: 280,
              height: 210,
              decoration: BoxDecoration(
                color: const Color(0xFFF0FDFA),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: const Color(0xFF10B981).withOpacity(0.1),
                  width: 2,
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.asset(
                      'assets/oi4.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(0xFFF5F3FF),
                          child: const Center(
                            child: Icon(
                              Icons.image_not_supported,
                              color: Color(0xFF7c3bed),
                              size: 48,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
            // Title
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Study smarter, ',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: const Color(0xFF130e1b),
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                  ),
                  TextSpan(
                    text: '\nnot harder',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: const Color(0xFF7c3bed),
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Subtitle
            Text(
              'Flashcards, quizzes, reminders — all personalized to how you learn best.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: const Color(0xFF4a4555),
                    fontSize: 18,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
