import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({
    super.key,
  });

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget>
    with TickerProviderStateMixin {
  late Map<int, AnimationController> _animationControllers;

  @override
  void initState() {
    super.initState();
    _animationControllers = {
      0: AnimationController(duration: const Duration(milliseconds: 300), vsync: this),
      1: AnimationController(duration: const Duration(milliseconds: 300), vsync: this),
      2: AnimationController(duration: const Duration(milliseconds: 300), vsync: this),
      3: AnimationController(duration: const Duration(milliseconds: 300), vsync: this),
    };
  }

  @override
  void dispose() {
    for (var controller in _animationControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  int _getCurrentIndex(String location) {
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/library')) return 1;
    if (location.startsWith('/practice')) return 2;
    if (location.startsWith('/settings') || location.startsWith('/dyslexia')) return 3;
    return 0;
  }

  void _handleTap(int index, String route) {
    // Always play animation and navigate
    _animationControllers[index]!.forward().then((_) {
      _animationControllers[index]!.reverse();
      if (mounted) {
        context.go(route);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentLocation = GoRouterState.of(context).uri.toString();
    final currentIndex = _getCurrentIndex(currentLocation);

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
                context: context,
                icon: Icons.home,
                label: 'Home',
                index: 0,
                isActive: currentIndex == 0,
                route: '/home',
                animationController: _animationControllers[0]!,
              ),
              _buildNavItem(
                context: context,
                icon: Icons.local_library_outlined,
                label: 'Library',
                index: 1,
                isActive: currentIndex == 1,
                route: '/library',
                animationController: _animationControllers[1]!,
              ),
              _buildNavItem(
                context: context,
                icon: Icons.draw_outlined,
                label: 'Practice',
                index: 2,
                isActive: currentIndex == 2,
                route: '/practice-quiz-menu',
                animationController: _animationControllers[2]!,
              ),
              _buildNavItem(
                context: context,
                icon: Icons.person_outline,
                label: 'Profile',
                index: 3,
                isActive: currentIndex == 3,
                route: '/settings',
                animationController: _animationControllers[3]!,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required int index,
    required bool isActive,
    required String route,
    required AnimationController animationController,
  }) {
    return ScaleTransition(
      scale: Tween<double>(begin: 1.0, end: 0.85).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
      ),
      child: GestureDetector(
        onTap: () {
          _handleTap(index, route);
        },
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
      ),
    );
  }
}
