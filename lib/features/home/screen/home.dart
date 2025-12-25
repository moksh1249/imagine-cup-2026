import 'package:flutter/material.dart';

// Models for data structure
class CourseCard {
  final String title;
  final String subject;
  final int progress;
  final String imageUrl;
  final String nextLesson;

  CourseCard({
    required this.title,
    required this.subject,
    required this.progress,
    required this.imageUrl,
    required this.nextLesson,
  });
}

class RevisionTopic {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final String title;
  final String tag;

  RevisionTopic({
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.title,
    required this.tag,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  // User data variables
  String username = 'Rahul';
  String greeting = 'Good morning';
  String profileImageUrl =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuDMjyb3dH-kegxecxohxSKn-rJYu7ku4ZKGY7LlqgQLH5LNV1uVZ_7FFSscP8lWKuu81VxwnU9ZVI8f6f99ExnjQX0ElLbEpF1_tPuJlKasEUUVSdmVeiKcBhLzmAJUqc2hK_fI0E4vniYk90KUQ8YFHZR3SeO4vckJ4wx4fwYGqYltWx0UhsmavQPDk21lEZ6uUolk_g34lyhCBn5RG2eO1kR5fODLqj8_Tq3AA7DrT88yIYPSrNZBOG5nKw-IbnJ8DhnaDFRMINg';
  int streakDays = 5;

  // Today's Goal variables
  int dailyGoalProgress = 50;
  String dailyGoalTitle = 'Complete 2 lectures';
  int dailyGoalCompleted = 1;
  int dailyGoalTotal = 2;

  // Course cards data
  List<CourseCard> courseCards = [
    CourseCard(
      title: 'Intro to Biology',
      subject: 'Biology 101',
      progress: 70,
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDlX0It-twhE_eNdiEv27RQ-KaA1cQY6_ng9gDBXPonFIrhuUT1mFkNU9KReQjmW5515tb0LoR57_ieECqbrTqXM1X_pkD17fL9dg3KL2dQNcabpsf8MFlXRaQGlC9muDCgxWobn2twQSROm_WOO_3lHVxOinH0YabG-acxtQWyN88vpnmTW-Y59MwPGf9qolxtN6Jbv4GDtMZwaXFXzcbMSNCYrwjg9uhTb_oynUd6c61joe_7cMtSinUXbUxT6q5IYo4B4DvSgq0',
      nextLesson: 'Cellular Respiration',
    ),
    CourseCard(
      title: 'Modern History',
      subject: 'History',
      progress: 20,
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCQfqNDhJT_3zukBEIGbe-v5GfHOW3dy6Gn2f0ui1cLe5JBvQSa0KJWt3NtvXu76XgwZNjjc9XOf-owCp3FaKqvwIKNmEd6U5MHjzyZHn-7Kgne-4Zp3h4ZLPnGON1dcMs0eWXWOYqgu1rgwqOlmIZboNixRCKRA-7fJB0Qn9vQt35j_pkPAEV7lp0B8oCMsaJ94m8-7SBsJ86AXn7FEUr8mWNvarQNSLDXhi_zK2KESI735e7MxKKoEoXrlP6xsY93FiBzMe-3LiQ',
      nextLesson: 'The Industrial Revolution',
    ),
  ];

  // Revision topics data
  List<RevisionTopic> revisionTopics = [
    RevisionTopic(
      icon: Icons.functions,
      iconColor: const Color(0xFFF97316),
      backgroundColor: const Color(0xFFFEF3C7),
      title: 'Quadratic Equations',
      tag: 'Math',
    ),
    RevisionTopic(
      icon: Icons.eco,
      iconColor: const Color(0xFF10B981),
      backgroundColor: const Color(0xFFD1FAE5),
      title: 'Photosynthesis',
      tag: 'Bio',
    ),
  ];

  // Animation controllers
  Map<String, AnimationController> _animationControllers = {};

  @override
  void initState() {
    super.initState();
    _initializeAnimationControllers();
  }

  void _initializeAnimationControllers() {
    _animationControllers['viewAll'] = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    for (int i = 0; i < courseCards.length; i++) {
      _animationControllers['resume_$i'] = AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this,
      );
    }

    for (int i = 0; i < revisionTopics.length; i++) {
      _animationControllers['reload_$i'] = AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this,
      );
    }
  }

  @override
  void dispose() {
    for (var controller in _animationControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _handleButtonPress(String buttonKey) {
    if (_animationControllers.containsKey(buttonKey)) {
      _animationControllers[buttonKey]!.forward().then((_) {
        _animationControllers[buttonKey]!.reverse();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(
              height: MediaQuery.of(context).size.height - 200,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  const SizedBox(height: 32),
                  _buildTodaysGoal(),
                  const SizedBox(height: 32),
                  _buildContinueLearning(),
                  const SizedBox(height: 32),
                  _buildNeedsRevision(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: const Color(0xFFFFFBF5),
      padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greeting,
                style: const TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Hi, $username 👋',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                )
              ],
              image: DecorationImage(
                image: NetworkImage(profileImageUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  height: 12,
                  width: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF10B981),
                    border: Border.all(color: const Color(0xFFFFFBF5), width: 2),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodaysGoal() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFF7C3AED).withOpacity(0.05),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7C3AED).withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Today\'s Goal',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Keep the momentum going!',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6B7280),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFF10B981).withOpacity(0.2),
                  ),
                ),
                child: Row(
                  children: [
                    const Text('🔥', style: TextStyle(fontSize: 16)),
                    const SizedBox(width: 6),
                    Text(
                      '$streakDays day streak',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF10B981),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 96,
                      height: 96,
                      child: CircularProgressIndicator(
                        value: dailyGoalProgress / 100,
                        strokeWidth: 4,
                        backgroundColor: const Color(0xFFF3F4F6),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF7C3AED),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$dailyGoalProgress%',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF7C3AED),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dailyGoalTitle,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF10B981),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '$dailyGoalCompleted of $dailyGoalTotal completed',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContinueLearning() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Continue Learning',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            _buildAnimatedButton(
              buttonKey: 'viewAll',
              label: 'View All',
              onPressed: () => _handleButtonPress('viewAll'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 320,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: courseCards.length,
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, index) => _buildCourseCard(
              course: courseCards[index],
              buttonKey: 'resume_$index',
              onPressed: () => _handleButtonPress('resume_$index'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCourseCard({
    required CourseCard course,
    required String buttonKey,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 160,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              image: DecorationImage(
                image: NetworkImage(course.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.6),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      course.subject,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        course.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF7C3AED).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '${course.progress}%',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF7C3AED),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Next: ${course.nextLesson}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: course.progress / 100,
                    backgroundColor: const Color(0xFFF3F4F6),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF7C3AED),
                    ),
                    minHeight: 6,
                  ),
                ),
                const SizedBox(height: 12),
                ScaleTransition(
                  scale: Tween<double>(begin: 1.0, end: 0.95).animate(
                    CurvedAnimation(
                      parent: _animationControllers[buttonKey]!,
                      curve: Curves.easeInOut,
                    ),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFFBF5),
                        side: const BorderSide(
                          color: Color(0xFF7C3AED),
                          width: 0.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      onPressed: onPressed,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.play_circle_filled,
                            color: Color(0xFF7C3AED),
                            size: 18,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Resume',
                            style: TextStyle(
                              color: Color(0xFF1F2937),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
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

  Widget _buildNeedsRevision() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Needs Revision',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
          ),
        ),
        const SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: revisionTopics.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) => _buildTopicCard(
            topic: revisionTopics[index],
            buttonKey: 'reload_$index',
            onPressed: () => _handleButtonPress('reload_$index'),
          ),
        ),
      ],
    );
  }

  Widget _buildTopicCard({
    required RevisionTopic topic,
    required String buttonKey,
    required VoidCallback onPressed,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: topic.backgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              topic.icon,
              color: topic.iconColor,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  topic.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    topic.tag,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF4B5563),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ScaleTransition(
            scale: Tween<double>(begin: 1.0, end: 0.9).animate(
              CurvedAnimation(
                parent: _animationControllers[buttonKey]!,
                curve: Curves.easeInOut,
              ),
            ),
            child: GestureDetector(
              onTap: onPressed,
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF7C3AED).withOpacity(0.05),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.refresh,
                  color: Color(0xFF7C3AED),
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedButton({
    required String buttonKey,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ScaleTransition(
      scale: Tween<double>(begin: 1.0, end: 0.95).animate(
        CurvedAnimation(
          parent: _animationControllers[buttonKey]!,
          curve: Curves.easeInOut,
        ),
      ),
      child: GestureDetector(
        onTap: onPressed,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF7C3AED),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: const Color(0xFFE5E7EB),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.home,
                label: 'Home',
                index: 0,
                isFilled: true,
              ),
              _buildNavItem(
                icon: Icons.local_library_outlined,
                label: 'Library',
                index: 1,
              ),
              _buildNavItem(
                icon: Icons.draw_outlined,
                label: 'Practice',
                index: 2,
              ),
              _buildNavItem(
                icon: Icons.person_outline,
                label: 'Profile',
                index: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    bool isFilled = false,
  }) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            child: Icon(
              icon,
              color: index == 0 ? const Color(0xFF7C3AED) : const Color(0xFF9CA3AF),
              size: 24,
              fill: isFilled ? 1.0 : 0.0,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: index == 0 ? const Color(0xFF7C3AED) : const Color(0xFF9CA3AF),
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
