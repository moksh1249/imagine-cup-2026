import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_buddy/features/splash.dart';
import 'package:study_buddy/features/login/screen/login_screen.dart';
import 'package:study_buddy/features/signup/screen/signup_screen.dart';
import 'package:study_buddy/features/onboarding/onboarding_screen.dart';
import 'package:study_buddy/features/home/screen/home.dart';
import 'package:study_buddy/settings/settings_screen.dart';
import 'package:study_buddy/settings/dyslexia/dyslexia_screen.dart';
import 'package:study_buddy/features/library/screen/library_screen.dart';
import 'package:study_buddy/features/lecture_detail/screen/lecture_detail_screen.dart';
import 'package:study_buddy/features/upload/screen/upload_screen.dart';
import 'package:study_buddy/features/upload/screen/upload_progress_screen.dart';
import 'package:study_buddy/features/upload/screen/upload_complete_screen.dart';
import 'package:study_buddy/features/upload/screen/media_selection_screen.dart';
import 'package:study_buddy/features/upload/screen/upload_details_screen.dart';
import 'package:study_buddy/features/flashcards/screen/flashcards_dashboard_screen.dart';
import 'package:study_buddy/features/flashcards/screen/flashcard_deck_screen.dart';
import 'package:study_buddy/features/flashcards/screen/flashcard_question_screen.dart';
import 'package:study_buddy/features/flashcards/screen/flashcard_answer_screen.dart';
import 'package:study_buddy/features/flashcards/screen/flashcard_question_screen_v2.dart';
import 'package:study_buddy/features/flashcards/screen/flashcard_complete_screen.dart';
import 'package:study_buddy/features/notes/screen/transcript_screen.dart';
import 'package:study_buddy/features/notes/screen/notes_screen.dart';
import 'package:study_buddy/features/notes/screen/dyslexia_notes_screen.dart';
import 'package:study_buddy/features/notes/screen/adhd_notes_screen.dart';
import 'package:study_buddy/features/quiz/screen/practice_quiz_menu_screen.dart';
import 'package:study_buddy/features/quiz/screen/quiz_question_screen.dart';
import 'package:study_buddy/features/quiz/screen/quiz_feedback_correct_screen.dart';
import 'package:study_buddy/features/quiz/screen/quiz_feedback_incorrect_screen.dart';
import 'package:study_buddy/features/quiz/screen/quiz_results_screen.dart';
import 'package:study_buddy/features/profile_result/screen/profile_result_screen.dart';
import 'package:study_buddy/features/daily_summary/screen/daily_summary_screen.dart';
import 'package:study_buddy/features/session_complete/screen/session_complete_screen.dart';
import 'package:study_buddy/settings/adhd/adhd_settings_screen.dart';
import 'package:study_buddy/settings/edit_profile/edit_profile_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/splash',
  errorBuilder: (context, state) {
    return Scaffold(
      body: Center(
        child: Text('Error: ${state.error}'),
      ),
    );
  },
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
    GoRoute(
      path: '/library',
      name: 'library',
      builder: (context, state) => const LibraryScreen(),
    ),
    GoRoute(
      path: '/lecture-detail',
      name: 'lecture-detail',
      builder: (context, state) => const LectureDetailScreen(),
    ),
    GoRoute(
      path: '/media-selection',
      name: 'media-selection',
      builder: (context, state) => const MediaSelectionScreen(),
    ),
    GoRoute(
      path: '/upload-details/:uploadType',
      name: 'upload-details',
      builder: (context, state) {
        final uploadType = state.pathParameters['uploadType'] ?? 'upload_file';
        return UploadDetailsScreen(uploadType: uploadType);
      },
    ),
    GoRoute(
      path: '/upload',
      name: 'upload',
      builder: (context, state) => const UploadScreen(),
    ),
    GoRoute(
      path: '/upload-progress',
      name: 'upload-progress',
      builder: (context, state) => const UploadProgressScreen(),
    ),
    GoRoute(
      path: '/upload-complete',
      name: 'upload-complete',
      builder: (context, state) => const UploadCompleteScreen(),
    ),
    GoRoute(
      path: '/flashcards-dashboard',
      name: 'flashcards-dashboard',
      builder: (context, state) => const FlashcardsDashboardScreen(),
    ),
    GoRoute(
      path: '/flashcard-deck',
      name: 'flashcard-deck',
      builder: (context, state) => const FlashcardDeckScreen(),
    ),
    GoRoute(
      path: '/flashcard-question',
      name: 'flashcard-question',
      builder: (context, state) => const FlashcardQuestionScreen(),
    ),
    GoRoute(
      path: '/flashcard-answer',
      name: 'flashcard-answer',
      builder: (context, state) => const FlashcardAnswerScreen(),
    ),
    GoRoute(
      path: '/flashcard-question-v2',
      name: 'flashcard-question-v2',
      builder: (context, state) => const FlashcardQuestionScreenV2(),
    ),
    GoRoute(
      path: '/flashcard-complete',
      name: 'flashcard-complete',
      builder: (context, state) => const FlashcardCompleteScreen(),
    ),
    GoRoute(
      path: '/transcript',
      name: 'transcript',
      builder: (context, state) => const TranscriptScreen(),
    ),
    GoRoute(
      path: '/notes',
      name: 'notes',
      builder: (context, state) => const NotesScreen(),
    ),
    GoRoute(
      path: '/dyslexia-notes',
      name: 'dyslexia-notes',
      builder: (context, state) => const DyslexiaNotesScreen(),
    ),
    GoRoute(
      path: '/adhd-notes',
      name: 'adhd-notes',
      builder: (context, state) => const ADHDNotesScreen(),
    ),
    GoRoute(
      path: '/practice-quiz-menu',
      name: 'practice-quiz-menu',
      builder: (context, state) => const PracticeQuizMenuScreen(),
    ),
    GoRoute(
      path: '/quiz-question',
      name: 'quiz-question',
      builder: (context, state) => const QuizQuestionScreen(),
    ),
    GoRoute(
      path: '/quiz-feedback-correct',
      name: 'quiz-feedback-correct',
      builder: (context, state) => const QuizFeedbackCorrectScreen(),
    ),
    GoRoute(
      path: '/quiz-feedback-incorrect',
      name: 'quiz-feedback-incorrect',
      builder: (context, state) => const QuizFeedbackIncorrectScreen(),
    ),
    GoRoute(
      path: '/quiz-results',
      name: 'quiz-results',
      builder: (context, state) => const QuizResultsScreen(),
    ),
    GoRoute(
      path: '/profile-result',
      name: 'profile-result',
      builder: (context, state) => const ProfileResultScreen(),
    ),
    GoRoute(
      path: '/daily-summary',
      name: 'daily-summary',
      builder: (context, state) => const DailySummaryScreen(),
    ),
    GoRoute(
      path: '/session-complete',
      name: 'session-complete',
      builder: (context, state) => const SessionCompleteScreen(),
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/dyslexia',
      name: 'dyslexia',
      builder: (context, state) => const DyslexiaScreen(),
    ),
    GoRoute(
      path: '/adhd-settings',
      name: 'adhd-settings',
      builder: (context, state) => const ADHDSettingsScreen(),
    ),
    GoRoute(
      path: '/edit-profile',
      name: 'edit-profile',
      builder: (context, state) => const EditProfileScreen(),
    ),
  ],
);