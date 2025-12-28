import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF130e1b)),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Upload Lecture',
          style: TextStyle(
            color: Color(0xFF130e1b),
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lexend',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              const Text(
                'Upload your lecture',
                style: TextStyle(
                  color: Color(0xFF130e1b),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lexend',
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Record or upload an audio/video file to create AI-powered study materials',
                style: TextStyle(
                  color: Color(0xFF6b7280),
                  fontSize: 14,
                  fontFamily: 'Lexend',
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              // Upload options
              _buildUploadOption(
                icon: Icons.videocam_outlined,
                title: 'Record Video',
                description: 'Record your lecture directly in the app',
                color: const Color(0xFF7e37f1),
                onTap: () {
                  context.push('/upload-progress');
                },
              ),
              const SizedBox(height: 16),
              _buildUploadOption(
                icon: Icons.mic_outlined,
                title: 'Record Audio',
                description: 'Record just audio from your lecture',
                color: const Color(0xFF10B981),
                onTap: () {
                  context.push('/upload-progress');
                },
              ),
              const SizedBox(height: 16),
              _buildUploadOption(
                icon: Icons.folder_outlined,
                title: 'Upload File',
                description: 'Upload existing video or audio file',
                color: const Color(0xFFF59E0B),
                onTap: () {
                  context.push('/upload-progress');
                },
              ),
              const SizedBox(height: 16),
              _buildUploadOption(
                icon: Icons.link_outlined,
                title: 'Paste URL',
                description: 'Paste YouTube or other video link',
                color: const Color(0xFFEF4444),
                onTap: () {
                  context.push('/upload-progress');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUploadOption({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withOpacity(0.2),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 32),
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
                      fontSize: 12,
                      fontFamily: 'Lexend',
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward, color: color),
          ],
        ),
      ),
    );
  }
}
