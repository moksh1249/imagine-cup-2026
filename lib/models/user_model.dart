class UserModel {
  final String name;
  final String email;
  final String? profileImagePath; // Local file path to profile image
  final String grade;
  final List<String> subjects;
  final bool visualLearning;
  final bool audioLearning;
  final bool handsOnLearning;

  UserModel({
    required this.name,
    required this.email,
    this.profileImagePath,
    required this.grade,
    required this.subjects,
    required this.visualLearning,
    required this.audioLearning,
    required this.handsOnLearning,
  });

  // Create a copy with modified fields
  UserModel copyWith({
    String? name,
    String? email,
    String? profileImagePath,
    String? grade,
    List<String>? subjects,
    bool? visualLearning,
    bool? audioLearning,
    bool? handsOnLearning,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      grade: grade ?? this.grade,
      subjects: subjects ?? this.subjects,
      visualLearning: visualLearning ?? this.visualLearning,
      audioLearning: audioLearning ?? this.audioLearning,
      handsOnLearning: handsOnLearning ?? this.handsOnLearning,
    );
  }

  // Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'profileImagePath': profileImagePath,
      'grade': grade,
      'subjects': subjects,
      'visualLearning': visualLearning,
      'audioLearning': audioLearning,
      'handsOnLearning': handsOnLearning,
    };
  }

  // Create from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? 'User',
      email: json['email'] ?? 'user@example.com',
      profileImagePath: json['profileImagePath'],
      grade: json['grade'] ?? 'Grade 10',
      subjects: List<String>.from(json['subjects'] ?? []),
      visualLearning: json['visualLearning'] ?? true,
      audioLearning: json['audioLearning'] ?? false,
      handsOnLearning: json['handsOnLearning'] ?? true,
    );
  }

  // Default user model
  static UserModel defaultUser() {
    return UserModel(
      name: 'Rahul',
      email: 'rahul@example.com',
      profileImagePath: null,
      grade: 'Grade 10',
      subjects: ['Physics', 'Chemistry'],
      visualLearning: true,
      audioLearning: false,
      handsOnLearning: true,
    );
  }
}
