import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_buddy/common/common_app_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:study_buddy/services/user_service.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  String selectedGrade = 'Grade 10';
  List<String> selectedSubjects = ['Physics', 'Chemistry'];
  List<String> availableSubjects = [
    'Physics',
    'Chemistry',
    'Math',
    'Biology',
    'English',
    'History',
    'Geography',
    'Computer Science'
  ];
  
  // Learning preferences
  bool visualLearning = true;
  bool audioLearning = false;
  bool handsOnLearning = true;
  
  // Profile image
  File? profileImage;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    
    // Load user data from UserService
    final userService = UserService();
    nameController = TextEditingController(text: userService.name);
    emailController = TextEditingController(text: userService.email);
    selectedGrade = userService.grade;
    selectedSubjects = List.from(userService.subjects);
    visualLearning = userService.visualLearning;
    audioLearning = userService.audioLearning;
    handsOnLearning = userService.handsOnLearning;
    
    // Set profile image if it exists
    if (userService.profileImagePath != null) {
      profileImage = File(userService.profileImagePath!);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      
      if (pickedFile != null) {
        setState(() {
          profileImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error picking image: $e')),
        );
      }
    }
  }

  void _addSubject(String subject) {
    if (!selectedSubjects.contains(subject)) {
      setState(() {
        selectedSubjects.add(subject);
      });
    }
  }

  void _removeSubject(String subject) {
    setState(() {
      selectedSubjects.remove(subject);
    });
  }

  Future<void> _saveChanges() async {
    try {
      final userService = UserService();
      
      await userService.updateUserData(
        name: nameController.text,
        email: emailController.text,
        profileImagePath: profileImage?.path,
        grade: selectedGrade,
        subjects: selectedSubjects,
        visualLearning: visualLearning,
        audioLearning: audioLearning,
        handsOnLearning: handsOnLearning,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully'),
            duration: Duration(seconds: 2),
          ),
        );
        
        // Pop after a brief delay
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) context.pop();
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving profile: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: CommonAppBar(
          title: 'Edit Profile',
          showBackButton: true,
          onBackPressed: null,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile picture
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color(0xFF7e37f1).withOpacity(0.1),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF7e37f1),
                          width: 2,
                        ),
                      ),
                      child: profileImage != null && !kIsWeb
                          ? ClipOval(
                              child: Image.file(
                                profileImage!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : const Icon(
                              Icons.person,
                              size: 50,
                              color: Color(0xFF7e37f1),
                            ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF7e37f1),
                        side: const BorderSide(
                          color: Color(0xFF7e37f1),
                          width: 2,
                        ),
                      ),
                      onPressed: _pickImage,
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Change Picture'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // Form fields
              const Text(
                'Personal Information',
                style: TextStyle(
                  color: Color(0xFF130e1b),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lexend',
                ),
              ),
              const SizedBox(height: 16),
              _buildTextField(
                'Full Name',
                nameController,
                'Enter your full name',
              ),
              const SizedBox(height: 16),
              _buildTextField(
                'Email',
                emailController,
                'Enter your email',
              ),
              const SizedBox(height: 32),
              // Education info
              const Text(
                'Education',
                style: TextStyle(
                  color: Color(0xFF130e1b),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lexend',
                ),
              ),
              const SizedBox(height: 16),
              _buildDropdown(
                'Grade/Level',
                selectedGrade,
                ['Grade 9', 'Grade 10', 'Grade 11', 'Grade 12'],
                (value) {
                  setState(() => selectedGrade = value);
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Main Subjects',
                style: TextStyle(
                  color: Color(0xFF130e1b),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lexend',
                ),
              ),
              const SizedBox(height: 8),
              // Selected subjects display
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (selectedSubjects.isEmpty)
                      const Text(
                        'No subjects selected',
                        style: TextStyle(
                          color: Color(0xFF6b7280),
                          fontFamily: 'Lexend',
                        ),
                      )
                    else
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: selectedSubjects.map((subject) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF7e37f1).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xFF7e37f1),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  subject,
                                  style: const TextStyle(
                                    color: Color(0xFF130e1b),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Lexend',
                                  ),
                                ),
                                const SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () => _removeSubject(subject),
                                  child: const Icon(
                                    Icons.close,
                                    size: 16,
                                    color: Color(0xFF7e37f1),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    const SizedBox(height: 12),
                    // Add subject dropdown
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFBF5),
                        border: Border.all(color: const Color(0xFFE5E7EB)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButton<String>(
                        hint: const Text(
                          'Add subject...',
                          style: TextStyle(
                            color: Color(0xFF6b7280),
                            fontFamily: 'Lexend',
                          ),
                        ),
                        isExpanded: true,
                        underline: const SizedBox(),
                        onChanged: (value) {
                          if (value != null) {
                            _addSubject(value);
                          }
                        },
                        items: availableSubjects
                            .where((s) => !selectedSubjects.contains(s))
                            .map((String subject) {
                          return DropdownMenuItem<String>(
                            value: subject,
                            child: Text(
                              subject,
                              style: const TextStyle(
                                color: Color(0xFF130e1b),
                                fontFamily: 'Lexend',
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // Learning preferences
              const Text(
                'Learning Preferences',
                style: TextStyle(
                  color: Color(0xFF130e1b),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lexend',
                ),
              ),
              const SizedBox(height: 16),
              _buildCheckboxOption(
                'Visual Learning',
                visualLearning,
                (value) {
                  setState(() => visualLearning = value ?? false);
                },
              ),
              const SizedBox(height: 12),
              _buildCheckboxOption(
                'Audio Learning',
                audioLearning,
                (value) {
                  setState(() => audioLearning = value ?? false);
                },
              ),
              const SizedBox(height: 12),
              _buildCheckboxOption(
                'Hands-on Learning',
                handsOnLearning,
                (value) {
                  setState(() => handsOnLearning = value ?? false);
                },
              ),
              const SizedBox(height: 32),
              // Action buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7e37f1),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _saveChanges,
                  child: const Text(
                    'Save Changes',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Lexend',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(
                      color: Color(0xFF7e37f1),
                      width: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    context.pop();
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Color(0xFF7e37f1),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Lexend',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    String hint, {
    bool enabled = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF130e1b),
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lexend',
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          enabled: enabled,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: Color(0xFF6b7280),
              fontFamily: 'Lexend',
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFFE5E7EB),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFFE5E7EB),
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          style: const TextStyle(
            color: Color(0xFF130e1b),
            fontFamily: 'Lexend',
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown(
    String label,
    String value,
    List<String> options,
    Function(String) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF130e1b),
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lexend',
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFFE5E7EB)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            underline: const SizedBox(),
            onChanged: (newValue) {
              if (newValue != null) onChanged(newValue);
            },
            items: options.map((String option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(
                  option,
                  style: const TextStyle(
                    color: Color(0xFF130e1b),
                    fontFamily: 'Lexend',
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildCheckboxOption(
    String label,
    bool value,
    Function(bool?)? onChanged,
  ) {
    return GestureDetector(
      onTap: onChanged != null
          ? () => onChanged(!value)
          : null,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: value ? const Color(0xFF7e37f1).withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: value
                ? const Color(0xFF7e37f1)
                : const Color(0xFFE5E7EB),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF130e1b),
                fontSize: 14,
                fontFamily: 'Lexend',
              ),
            ),
            Checkbox(
              value: value,
              onChanged: onChanged,
              activeColor: const Color(0xFF7e37f1),
            ),
          ],
        ),
      ),
    );
  }
}
