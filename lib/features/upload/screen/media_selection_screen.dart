import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_buddy/common/common_app_bar.dart';

class MediaSelectionScreen extends StatefulWidget {
  const MediaSelectionScreen({super.key});

  @override
  State<MediaSelectionScreen> createState() => _MediaSelectionScreenState();
}

class _MediaSelectionScreenState extends State<MediaSelectionScreen> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: CommonAppBar(
          title: 'Add to Library',
          showBackButton: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              const Text(
                'Choose a file type to upload',
                style: TextStyle(
                  color: Color(0xFF130e1b),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lexend',
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Select one of the options below to add new content to your library',
                style: TextStyle(
                  color: Color(0xFF6b7280),
                  fontSize: 14,
                  fontFamily: 'Lexend',
                ),
              ),
              const SizedBox(height: 32),
              // Record Audio
              _buildMediaOption(
                icon: Icons.mic,
                title: 'Record Audio',
                description: 'Record an audio lecture or note',
                value: 'record_audio',
                onTap: () {
                  _handleSelection('record_audio');
                },
              ),
              const SizedBox(height: 16),
              // Record Video
              _buildMediaOption(
                icon: Icons.videocam,
                title: 'Record Video',
                description: 'Record a video lecture',
                value: 'record_video',
                onTap: () {
                  _handleSelection('record_video');
                },
              ),
              const SizedBox(height: 16),
              // Upload File
              _buildMediaOption(
                icon: Icons.file_present,
                title: 'Upload File',
                description: 'Upload PDF, documents, or other files',
                value: 'upload_file',
                onTap: () {
                  _handleSelection('upload_file');
                },
              ),
              const SizedBox(height: 16),
              // Paste URL
              _buildMediaOption(
                icon: Icons.link,
                title: 'Paste URL',
                description: 'Add content from a URL link',
                value: 'paste_url',
                onTap: () {
                  _handleSelection('paste_url');
                },
              ),
              const SizedBox(height: 48),
              // Continue Button
              if (_selectedOption != null)
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
                    onPressed: () {
                      _handleContinue();
                    },
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lexend',
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMediaOption({
    required IconData icon,
    required String title,
    required String description,
    required String value,
    required VoidCallback onTap,
  }) {
    final isSelected = _selectedOption == value;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF7e37f1).withOpacity(0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF7e37f1)
                : const Color(0xFFE5E7EB),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF7e37f1)
                    : const Color(0xFF7e37f1).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : const Color(0xFF7e37f1),
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF130e1b),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Lexend',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Color(0xFF6b7280),
                      fontSize: 13,
                      fontFamily: 'Lexend',
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: Color(0xFF7e37f1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 14,
                ),
              )
            else
              Icon(
                Icons.radio_button_unchecked,
                color: const Color(0xFF7e37f1).withOpacity(0.3),
              ),
          ],
        ),
      ),
    );
  }

  void _handleSelection(String option) {
    setState(() {
      _selectedOption = option;
    });
  }

  void _handleContinue() {
    switch (_selectedOption) {
      case 'record_audio':
        context.push('/upload-details/record_audio');
        break;
      case 'record_video':
        context.push('/upload-details/record_video');
        break;
      case 'upload_file':
        context.push('/upload-details/upload_file');
        break;
      case 'paste_url':
        context.push('/upload-details/paste_url');
        break;
      default:
        break;
    }
  }
}
