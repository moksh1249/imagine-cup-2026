import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:study_buddy/models/user_model.dart';

class UserService extends ChangeNotifier {
  static final UserService _instance = UserService._internal();
  
  factory UserService() {
    return _instance;
  }

  UserService._internal();

  late SharedPreferences _prefs;
  late UserModel _userData;
  bool _isInitialized = false;

  // Getters
  UserModel get userData => _userData;
  bool get isInitialized => _isInitialized;

  String get name => _userData.name;
  String get email => _userData.email;
  String? get profileImagePath => _userData.profileImagePath;
  String get grade => _userData.grade;
  List<String> get subjects => _userData.subjects;
  bool get visualLearning => _userData.visualLearning;
  bool get audioLearning => _userData.audioLearning;
  bool get handsOnLearning => _userData.handsOnLearning;

  // Initialize the service
  Future<void> initialize() async {
    if (_isInitialized) return;

    _prefs = await SharedPreferences.getInstance();
    
    // Load user data from SharedPreferences
    final userJson = _prefs.getString('user_data');
    if (userJson != null) {
      try {
        _userData = UserModel.fromJson(jsonDecode(userJson));
      } catch (e) {
        _userData = UserModel.defaultUser();
      }
    } else {
      _userData = UserModel.defaultUser();
    }

    _isInitialized = true;
    notifyListeners();
  }

  // Update user name
  Future<void> updateName(String name) async {
    _userData = _userData.copyWith(name: name);
    await _saveToPreferences();
    notifyListeners();
  }

  // Update user email
  Future<void> updateEmail(String email) async {
    _userData = _userData.copyWith(email: email);
    await _saveToPreferences();
    notifyListeners();
  }

  // Update profile image path
  Future<void> updateProfileImagePath(String? imagePath) async {
    _userData = _userData.copyWith(profileImagePath: imagePath);
    await _saveToPreferences();
    notifyListeners();
  }

  // Update grade
  Future<void> updateGrade(String grade) async {
    _userData = _userData.copyWith(grade: grade);
    await _saveToPreferences();
    notifyListeners();
  }

  // Update subjects
  Future<void> updateSubjects(List<String> subjects) async {
    _userData = _userData.copyWith(subjects: subjects);
    await _saveToPreferences();
    notifyListeners();
  }

  // Add a subject
  Future<void> addSubject(String subject) async {
    if (!_userData.subjects.contains(subject)) {
      final newSubjects = [..._userData.subjects, subject];
      await updateSubjects(newSubjects);
    }
  }

  // Remove a subject
  Future<void> removeSubject(String subject) async {
    final newSubjects = _userData.subjects.where((s) => s != subject).toList();
    await updateSubjects(newSubjects);
  }

  // Update learning preferences
  Future<void> updateLearningPreferences({
    bool? visualLearning,
    bool? audioLearning,
    bool? handsOnLearning,
  }) async {
    _userData = _userData.copyWith(
      visualLearning: visualLearning ?? _userData.visualLearning,
      audioLearning: audioLearning ?? _userData.audioLearning,
      handsOnLearning: handsOnLearning ?? _userData.handsOnLearning,
    );
    await _saveToPreferences();
    notifyListeners();
  }

  // Update all user data at once
  Future<void> updateUserData({
    String? name,
    String? email,
    String? profileImagePath,
    String? grade,
    List<String>? subjects,
    bool? visualLearning,
    bool? audioLearning,
    bool? handsOnLearning,
  }) async {
    _userData = UserModel(
      name: name ?? _userData.name,
      email: email ?? _userData.email,
      profileImagePath: profileImagePath ?? _userData.profileImagePath,
      grade: grade ?? _userData.grade,
      subjects: subjects ?? _userData.subjects,
      visualLearning: visualLearning ?? _userData.visualLearning,
      audioLearning: audioLearning ?? _userData.audioLearning,
      handsOnLearning: handsOnLearning ?? _userData.handsOnLearning,
    );
    await _saveToPreferences();
    notifyListeners();
  }

  // Save to SharedPreferences
  Future<void> _saveToPreferences() async {
    try {
      await _prefs.setString('user_data', jsonEncode(_userData.toJson()));
    } catch (e) {
      debugPrint('Error saving user data: $e');
    }
  }

  // Reset to default
  Future<void> reset() async {
    _userData = UserModel.defaultUser();
    await _prefs.remove('user_data');
    notifyListeners();
  }
}
