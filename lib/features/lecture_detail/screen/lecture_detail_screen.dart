import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LectureDetailScreen extends StatefulWidget {
  const LectureDetailScreen({super.key});

  @override
  State<LectureDetailScreen> createState() => _LectureDetailScreenState();
}

class _LectureDetailScreenState extends State<LectureDetailScreen> {
  String selectedTab = 'Overview';
  final List<String> tabs = ['Overview', 'Transcript', 'Notes', 'Flashcards'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),
      body: CustomScrollView(
        slivers: [
          // App bar
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: const Color(0xFFFFFBF5),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Color(0xFF130e1b)),
              onPressed: () => context.pop(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuALc6XsTKaeYeJJapkxnuo28cbWaX81GLE6kl2trc9CFN6tzThEEaqeD7icmp4ZQCnT-PdnWaDrapSiKs_Qe3TjTR8Qftjdkm-5OY6XVG8ECltCiACQET3RMIw0MQHaMS9c5GBGH6mfHgabG1Hsx7r3HCrecmf3jQqLPPXCcZqmxOkDM7Vygm5t0LBGLWvBB_f_rSioXnPPiXQ1nZj2Zqs3L8J06wh2BMRrh5or5e0hoD3fg6Kxnf71THTvWVhQkaDjckKTFAUkX5g',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: const Color(0xFF7e37f1).withOpacity(0.1),
                      );
                    },
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.3),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Content
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Physics 101: Classical Mechanics',
                        style: TextStyle(
                          color: Color(0xFF130e1b),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Lexend',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Lecture 1 - Introduction to Motion',
                        style: TextStyle(
                          color: const Color(0xFF6b7280),
                          fontSize: 14,
                          fontFamily: 'Lexend',
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF7e37f1).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.info_outline,
                              color: Color(0xFF7e37f1),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                '45 minutes • 3 key topics',
                                style: const TextStyle(
                                  color: Color(0xFF7e37f1),
                                  fontSize: 14,
                                  fontFamily: 'Lexend',
                                ),
                              ),
                            ),
                          ],
                        ),
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
                                    fontSize: 16,
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
                                    width: 24,
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
                if (selectedTab == 'Overview')
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'About this lecture',
                          style: TextStyle(
                            color: Color(0xFF130e1b),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Lexend',
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Learn the fundamentals of classical mechanics including velocity, acceleration, and Newton\'s laws. This comprehensive lecture covers the essential concepts needed for physics mastery.',
                          style: TextStyle(
                            color: const Color(0xFF6b7280),
                            fontSize: 14,
                            height: 1.6,
                            fontFamily: 'Lexend',
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Key Topics',
                          style: TextStyle(
                            color: Color(0xFF130e1b),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Lexend',
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildTopicItem('Displacement & Velocity'),
                        _buildTopicItem('Acceleration & Forces'),
                        _buildTopicItem('Newton\'s Three Laws'),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF7e37f1),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            onPressed: () {
                              context.push('/transcript');
                            },
                            child: const Text(
                              'View Transcript',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Lexend',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopicItem(String topic) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFF7e37f1),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            topic,
            style: const TextStyle(
              color: Color(0xFF6b7280),
              fontSize: 14,
              fontFamily: 'Lexend',
            ),
          ),
        ],
      ),
    );
  }
}
