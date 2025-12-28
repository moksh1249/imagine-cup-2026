import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UploadProgressScreen extends StatefulWidget {
  const UploadProgressScreen({super.key});

  @override
  State<UploadProgressScreen> createState() => _UploadProgressScreenState();
}

class _UploadProgressScreenState extends State<UploadProgressScreen>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOutCubic),
    );

    _progressController.forward();

    // Navigate to completion screen after progress finishes
    Future.delayed(const Duration(seconds: 6), () {
      if (mounted) {
        context.push('/upload-complete');
      }
    });
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated progress indicator
            AnimatedBuilder(
              animation: _progressAnimation,
              builder: (context, child) {
                return Column(
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularProgressIndicator(
                            value: _progressAnimation.value,
                            strokeWidth: 8,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Color(0xFF7e37f1),
                            ),
                            backgroundColor: const Color(0xFF7e37f1)
                                .withOpacity(0.1),
                          ),
                          Text(
                            '${(_progressAnimation.value * 100).toStringAsFixed(0)}%',
                            style: const TextStyle(
                              color: Color(0xFF130e1b),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Lexend',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Processing your lecture',
                      style: TextStyle(
                        color: Color(0xFF130e1b),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lexend',
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Our AI is analyzing your content',
                      style: TextStyle(
                        color: Color(0xFF6b7280),
                        fontSize: 14,
                        fontFamily: 'Lexend',
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 60),
            // Status items
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  _buildStatusItem('Uploading file', true),
                  const SizedBox(height: 16),
                  _buildStatusItem(
                    'Transcribing audio',
                    _progressAnimation.value > 0.3,
                  ),
                  const SizedBox(height: 16),
                  _buildStatusItem(
                    'Generating notes',
                    _progressAnimation.value > 0.6,
                  ),
                  const SizedBox(height: 16),
                  _buildStatusItem(
                    'Creating flashcards',
                    _progressAnimation.value > 0.85,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusItem(String text, bool isComplete) {
    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: isComplete
                ? const Color(0xFF10B981)
                : const Color(0xFF7e37f1).withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(
              color: isComplete
                  ? const Color(0xFF10B981)
                  : const Color(0xFF7e37f1),
              width: 2,
            ),
          ),
          child: isComplete
              ? const Icon(Icons.check, color: Colors.white, size: 14)
              : null,
        ),
        const SizedBox(width: 12),
        Text(
          text,
          style: TextStyle(
            color: isComplete
                ? const Color(0xFF130e1b)
                : const Color(0xFF6b7280),
            fontSize: 14,
            fontFamily: 'Lexend',
            fontWeight: isComplete ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
