import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_buddy/common/common_app_bar.dart';

class UploadDetailsScreen extends StatefulWidget {
  final String uploadType; // record_audio, record_video, upload_file, paste_url

  const UploadDetailsScreen({
    super.key,
    required this.uploadType,
  });

  @override
  State<UploadDetailsScreen> createState() => _UploadDetailsScreenState();
}

class _UploadDetailsScreenState extends State<UploadDetailsScreen> {
  String selectedSubject = 'Physics';
  String? selectedFilePath;
  late TextEditingController urlController;

  final List<String> subjects = [
    'Physics',
    'Chemistry',
    'Math',
    'Biology',
    'English',
    'History',
    'Geography',
    'Computer Science',
  ];

  final Map<String, Map<String, dynamic>> uploadConfig = {
    'record_audio': {
      'title': 'Record Audio Lecture',
      'description': 'Record an audio lecture or note for your study library',
      'compatibleFormats': ['MP3', 'WAV', 'M4A', 'AAC'],
      'icon': Icons.mic,
      'color': Color(0xFF10B981),
      'maxSize': '500 MB',
    },
    'record_video': {
      'title': 'Record Video Lecture',
      'description': 'Record a video lecture for your study library',
      'compatibleFormats': ['MP4', 'MOV', 'AVI', 'WebM'],
      'icon': Icons.videocam,
      'color': Color(0xFF7e37f1),
      'maxSize': '2 GB',
    },
    'upload_file': {
      'title': 'Upload File',
      'description': 'Upload existing audio, video, or document files',
      'compatibleFormats': ['MP3', 'MP4', 'PDF', 'DOC', 'DOCX', 'PPT', 'PPTX', 'WAV', 'M4A'],
      'icon': Icons.file_present,
      'color': Color(0xFFF59E0B),
      'maxSize': '2 GB',
    },
    'paste_url': {
      'title': 'Paste URL Link',
      'description': 'Add content from YouTube, Vimeo, or other video platforms',
      'compatibleFormats': ['YouTube', 'Vimeo', 'Google Drive', 'OneDrive', 'Dropbox'],
      'icon': Icons.link,
      'color': Color(0xFFEF4444),
      'maxSize': 'Unlimited',
    },
  };

  @override
  void initState() {
    super.initState();
    urlController = TextEditingController();
  }

  @override
  void dispose() {
    urlController.dispose();
    super.dispose();
  }

  String _getTitle() {
    return uploadConfig[widget.uploadType]?['title'] ?? 'Upload Content';
  }

  String _getDescription() {
    return uploadConfig[widget.uploadType]?['description'] ?? '';
  }

  List<String> _getCompatibleFormats() {
    return uploadConfig[widget.uploadType]?['compatibleFormats'] ?? [];
  }

  Color _getColor() {
    return uploadConfig[widget.uploadType]?['color'] ?? const Color(0xFF7e37f1);
  }

  String _getMaxSize() {
    return uploadConfig[widget.uploadType]?['maxSize'] ?? 'Unknown';
  }

  void _handleUpload() {
    // Validate based on upload type
    if (widget.uploadType == 'paste_url') {
      if (urlController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please paste a URL')),
        );
        return;
      }
    } else if (widget.uploadType == 'upload_file') {
      if (selectedFilePath == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a file')),
        );
        return;
      }
    }

    // Proceed to upload progress screen
    context.push('/upload-progress');
  }

  @override
  Widget build(BuildContext context) {
    final config = uploadConfig[widget.uploadType];
    final compatibleFormats = _getCompatibleFormats();
    final color = _getColor();

    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: CommonAppBar(
          title: 'Upload Details',
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
              // Upload Type Info Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: color.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        config?['icon'] ?? Icons.file_present,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _getTitle(),
                            style: const TextStyle(
                              color: Color(0xFF130e1b),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Lexend',
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _getDescription(),
                            style: TextStyle(
                              color: const Color(0xFF6b7280),
                              fontSize: 12,
                              fontFamily: 'Lexend',
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Subject Selection
              const Text(
                'Select Subject',
                style: TextStyle(
                  color: Color(0xFF130e1b),
                  fontSize: 16,
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
                  value: selectedSubject,
                  isExpanded: true,
                  underline: const SizedBox(),
                  onChanged: (newValue) {
                    setState(() => selectedSubject = newValue ?? 'Physics');
                  },
                  items: subjects.map((String subject) {
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
              const SizedBox(height: 32),

              // File/URL Input Section
              Text(
                widget.uploadType == 'paste_url'
                    ? 'Paste URL'
                    : 'Select ${widget.uploadType == 'record_audio' ? 'Audio' : widget.uploadType == 'record_video' ? 'Video' : 'File'}',
                style: const TextStyle(
                  color: Color(0xFF130e1b),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lexend',
                ),
              ),
              const SizedBox(height: 8),
              if (widget.uploadType == 'paste_url')
                _buildUrlInput(color)
              else
                _buildFileInput(color),
              const SizedBox(height: 32),

              // Compatible Formats Info
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFFFE0B2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info,
                          color: const Color(0xFFF59E0B),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Compatible Formats',
                          style: TextStyle(
                            color: Color(0xFF92400E),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Lexend',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: compatibleFormats.map((format) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: color.withOpacity(0.3),
                            ),
                          ),
                          child: Text(
                            format,
                            style: TextStyle(
                              color: color,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Lexend',
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Text(
                          'Max File Size: ',
                          style: TextStyle(
                            color: Color(0xFF92400E),
                            fontSize: 12,
                            fontFamily: 'Lexend',
                          ),
                        ),
                        Text(
                          _getMaxSize(),
                          style: const TextStyle(
                            color: Color(0xFFF59E0B),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Lexend',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Upload Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _handleUpload,
                  child: Text(
                    widget.uploadType == 'paste_url'
                        ? 'Add URL'
                        : widget.uploadType == 'record_audio'
                            ? 'Start Recording'
                            : widget.uploadType == 'record_video'
                                ? 'Start Recording'
                                : 'Upload File',
                    style: const TextStyle(
                      color: Colors.white,
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

  Widget _buildUrlInput(Color color) {
    return Column(
      children: [
        TextField(
          controller: urlController,
          decoration: InputDecoration(
            hintText: 'Paste video URL here...',
            hintStyle: const TextStyle(
              color: Color(0xFF9CA3AF),
              fontFamily: 'Lexend',
            ),
            prefixIcon: Icon(Icons.link, color: color),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: color, width: 2),
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
          minLines: 1,
          maxLines: 3,
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color.withOpacity(0.2)),
          ),
          child: Text(
            'Example: https://www.youtube.com/watch?v=dQw4w9WgXcQ',
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontFamily: 'Lexend',
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFileInput(Color color) {
    return GestureDetector(
      onTap: () {
        // Simulate file picker
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'File picker will open to select ${widget.uploadType == 'record_audio' ? 'audio' : 'video'} file',
            ),
          ),
        );
        setState(() {
          selectedFilePath = 'sample_lecture.${widget.uploadType == 'record_audio' ? 'mp3' : 'mp4'}';
        });
      },
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 2,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          children: [
            if (selectedFilePath == null)
              Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      widget.uploadType == 'record_audio'
                          ? Icons.mic_none
                          : Icons.videocam_outlined,
                      color: color,
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Tap to select file',
                    style: TextStyle(
                      color: color,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Lexend',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'or drag and drop',
                    style: TextStyle(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 14,
                      fontFamily: 'Lexend',
                    ),
                  ),
                ],
              )
            else
              Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.check_circle,
                      color: Color(0xFF10B981),
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'File Selected',
                    style: TextStyle(
                      color: Color(0xFF10B981),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Lexend',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    selectedFilePath!.split('/').last,
                    style: const TextStyle(
                      color: Color(0xFF130e1b),
                      fontSize: 12,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilePath = null;
                      });
                    },
                    child: Text(
                      'Choose Different File',
                      style: TextStyle(
                        color: color,
                        fontSize: 12,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
