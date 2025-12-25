import 'package:go_router/go_router.dart';
import 'package:study_buddy/features/splash.dart';
import 'package:study_buddy/features/login/screen/login_screen.dart';
import 'package:study_buddy/features/signup/screen/signup_screen.dart';
import 'package:study_buddy/features/onboarding/onboarding_screen.dart';
import 'package:study_buddy/features/home/screen/home.dart';

final GoRouter router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      name: 'signup',
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
