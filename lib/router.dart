import 'package:go_router/go_router.dart';
import 'package:study_buddy/features/login/screen/login_screen.dart';
import 'package:study_buddy/features/signup/screen/signup_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/login',
  routes: [
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
  ],
);
