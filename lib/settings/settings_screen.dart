import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_buddy/common/bottom_navigation.dart';
import 'package:study_buddy/common/common_app_bar.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:study_buddy/services/user_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  File? _profileImage;
  late UserService _userService;

  @override
  void initState() {
    super.initState();
    _userService = UserService();
    _loadUserData();
    _userService.addListener(_onUserDataChanged);
  }

  void _loadUserData() {
    setState(() {
      if (_userService.profileImagePath != null) {
        _profileImage = File(_userService.profileImagePath!);
      }
    });
  }

  void _onUserDataChanged() {
    _loadUserData();
  }

  @override
  void dispose() {
    _userService.removeListener(_onUserDataChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: CommonAppBar(
          title: 'Profile',
          showBackButton: false,
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
      bottomNavigationBar: const BottomNavigationWidget(),
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
              ),
              child: _profileImage != null && !kIsWeb
                  ? ClipOval(
                      child: Image.file(
                        _profileImage!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : ClipOval(
                      child: Image.network(
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuDJOXV353alQUMwsFHsC30gpCTHSXrsEFemBcOdwSndhAaUYYEV-IZNRoRfx9KFi1n4ukJUqQriBMfq3zkg9ji7MfoEVR9i5BkI88-EZsWAzbZbjWyzW23zp-64EC3x-fUYs6HZOoH6j96_e411D4LkGUEkQbYz45cSjkIRmFDFII2gPAFsbczv1-VvyBAT4xOy-8fTe9dKpEn8IcGACLgAdHjdayOauLM6v-X9ZEAzrfpkwfehhak7coFLbemfWWTI6IECINEJl2w',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: const Color(0xFF7e37f1).withOpacity(0.1),
                            child: const Icon(
                              Icons.person,
                              color: Color(0xFF7e37f1),
                              size: 60,
                            ),
                          );
                        },
                      ),
                    ),
            ),
            GestureDetector(
              onTap: () => context.push('/edit-profile'),
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
        Text(
          _userService.name,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F1F2E),
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          _userService.email,
          style: const TextStyle(
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
          onTap: () {
            context.push('/edit-profile');
          },
        ),
        const SizedBox(height: 12),
        _buildMenuButton(
          icon: Icons.accessibility,
          label: 'ADHD Support',
          onTap: () {
            context.push('/adhd-settings');
          },
        ),
        const SizedBox(height: 12),
        _buildMenuButton(
          icon: Icons.visibility,
          label: 'Dyslexia Support',
          onTap: () {
            context.push('/dyslexia');
          },
        ),
      ],
    );
  }

  Widget _buildMenuButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey[200]!,
            width: 1,
          ),
          boxShadow: [
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
              color: const Color(0xFF5A5A75),
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F1F2E),
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey[400],
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
