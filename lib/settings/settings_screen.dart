import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_buddy/common/bottom_navigation.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with TickerProviderStateMixin {
  final int _currentIndex = 3; // Profile/Settings tab index
  bool _editProfilePressed = false;
  bool _settingsPressed = false;
  bool _adhdPressed = false;
  bool _dyslexiaPressed = false;
  late AnimationController _editProfileController;
  late AnimationController _settingsController;
  late AnimationController _adhdController;
  late AnimationController _dyslexiaController;

  @override
  void initState() {
    super.initState();
    _editProfileController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _settingsController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _adhdController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _dyslexiaController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _editProfileController.dispose();
    _settingsController.dispose();
    _adhdController.dispose();
    _dyslexiaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFBF5),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Color(0xFF1F1F2E),
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 8),
              // Profile Header
              _buildProfileHeader(),
              const SizedBox(height: 24),
              // Learning Mode Card
              _buildLearningModeCard(),
              const SizedBox(height: 24),
              // Stats Row
              _buildStatsRow(),
              const SizedBox(height: 24),
              // Menu Buttons
              _buildMenuButtons(),
              const SizedBox(height: 16),
              // Version Info
              Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: Text(
                  'StudyBuddy AI v1.0.4',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationWidget(
        currentIndex: _currentIndex,
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        // Profile Image with Camera Button
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              height: 128,
              width: 128,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 4,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF7C3AED).withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  )
                ],
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuDJOXV353alQUMwsFHsC30gpCTHSXrsEFemBcOdwSndhAaUYYEV-IZNRoRfx9KFi1n4ukJUqQriBMfq3zkg9ji7MfoEVR9i5BkI88-EZsWAzbZbjWyzW23zp-64EC3x-fUYs6HZOoH6j96_e411D4LkGUEkQbYz45cSjkIRmFDFII2gPAFsbczv1-VvyBAT4xOy-8fTe9dKpEn8IcGACLgAdHjdayOauLM6v-X9ZEAzrfpkwfehhak7coFLbemfWWTI6IECINEJl2w',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF7C3AED),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFFFFBF5),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                    )
                  ],
                ),
                child: const Icon(
                  Icons.photo_camera,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // User Info
        const Text(
          'Rahul Sharma',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F1F2E),
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'rahul.sharma@uni.edu',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF5A5A75),
          ),
        ),
      ],
    );
  }

  Widget _buildLearningModeCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF7C3AED).withOpacity(0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7C3AED).withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              color: const Color(0xFF7C3AED).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.accessibility_new,
              color: Color(0xFF7C3AED),
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Current Mode',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5A5A75),
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'ADHD + Dyslexia Support',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F1F2E),
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        _buildStatCard(
          value: '45',
          label: 'Lectures',
          icon: Icons.menu_book,
        ),
        const SizedBox(width: 12),
        _buildStatCard(
          value: '500',
          label: 'Cards',
          icon: Icons.style,
        ),
        const SizedBox(width: 12),
        _buildStatCard(
          value: '12',
          label: 'Streak',
          icon: Icons.local_fire_department,
          isHighlighted: true,
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String value,
    required String label,
    required IconData icon,
    bool isHighlighted = false,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isHighlighted
                ? const Color(0xFF10B981).withOpacity(0.2)
                : Colors.grey[200]!,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
            )
          ],
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: isHighlighted
                    ? const Color(0xFF10B981)
                    : const Color(0xFF1F1F2E),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: isHighlighted
                      ? const Color(0xFF10B981)
                      : const Color(0xFF5A5A75),
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: isHighlighted
                        ? const Color(0xFF10B981)
                        : const Color(0xFF5A5A75),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButtons() {
    return Column(
      children: [
        _buildMenuButton(
          icon: Icons.edit,
          label: 'Edit Profile',
          isPressed: _editProfilePressed,
          controller: _editProfileController,
          onTap: () {
            setState(() {
              _editProfilePressed = true;
            });
            _editProfileController.forward().then((_) {
              setState(() {
                _editProfilePressed = false;
              });
              _editProfileController.reverse();
            });
          },
        ),
        const SizedBox(height: 12),
        _buildMenuButton(
          icon: Icons.settings,
          label: 'Settings',
          isPressed: _settingsPressed,
          controller: _settingsController,
          onTap: () {
            setState(() {
              _settingsPressed = true;
            });
            _settingsController.forward().then((_) {
              setState(() {
                _settingsPressed = false;
              });
              _settingsController.reverse();
            });
          },
        ),
        const SizedBox(height: 12),
        _buildMenuButton(
          icon: Icons.help,
          label: 'ADHD Support',
          isPressed: _adhdPressed,
          controller: _adhdController,
          onTap: () {
            setState(() {
              _adhdPressed = true;
            });
            _adhdController.forward().then((_) {
              setState(() {
                _adhdPressed = false;
              });
              _adhdController.reverse();
            });
          },
        ),
        const SizedBox(height: 12),
        _buildMenuButton(
          icon: Icons.help,
          label: 'Dyslexia Support',
          isPressed: _dyslexiaPressed,
          controller: _dyslexiaController,
          onTap: () {
            setState(() {
              _dyslexiaPressed = true;
            });
            _dyslexiaController.forward().then((_) {
              setState(() {
                _dyslexiaPressed = false;
              });
              _dyslexiaController.reverse();
              // Navigate to dyslexia screen after animation completes
              context.push('/dyslexia');
            });
          },
        ),
      ],
    );
  }

  Widget _buildMenuButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required AnimationController controller,
    bool isPressed = false,
  }) {
    return ScaleTransition(
      scale: Tween<double>(begin: 1.0, end: 0.98).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOut),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: isPressed ? const Color(0xFF7C3AED) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: isPressed
                ? null
                : Border.all(
                    color: Colors.grey[200]!,
                    width: 1,
                  ),
            boxShadow: isPressed
                ? [
                    BoxShadow(
                      color: const Color(0xFF7C3AED).withOpacity(0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    )
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 8,
                    )
                  ],
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: isPressed ? Colors.white : const Color(0xFF5A5A75),
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isPressed ? Colors.white : const Color(0xFF1F1F2E),
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: isPressed
                    ? Colors.white.withOpacity(0.7)
                    : Colors.grey[400],
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
