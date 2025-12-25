import 'package:flutter/material.dart';

class BottomNavigationWidget extends StatelessWidget {
  final Function(int) onTabSelected;
  final int currentIndex;
  
  const BottomNavigationWidget({
    super.key,
    required this.onTabSelected,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
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
                isActive: currentIndex == 0,
                onTap: () => onTabSelected(0),
              ),
              _buildNavItem(
                icon: Icons.local_library_outlined,
                label: 'Library',
                index: 1,
                isActive: currentIndex == 1,
                onTap: () => onTabSelected(1),
              ),
              _buildNavItem(
                icon: Icons.draw_outlined,
                label: 'Practice',
                index: 2,
                isActive: currentIndex == 2,
                onTap: () => onTabSelected(2),
              ),
              _buildNavItem(
                icon: Icons.person_outline,
                label: 'Profile',
                index: 3,
                isActive: currentIndex == 3,
                onTap: () => onTabSelected(3),
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
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            child: Icon(
              icon,
              color: isActive ? const Color(0xFF7C3AED) : const Color(0xFF9CA3AF),
              size: 24,
              fill: isActive ? 1.0 : 0.0,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: isActive ? const Color(0xFF7C3AED) : const Color(0xFF9CA3AF),
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
