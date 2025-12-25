import 'package:flutter/material.dart';
import 'package:study_buddy/common/dyslexia_settings.dart';

class DyslexiaScreen extends StatefulWidget {
  const DyslexiaScreen({super.key});

  @override
  State<DyslexiaScreen> createState() => _DyslexiaScreenState();
}

class _DyslexiaScreenState extends State<DyslexiaScreen> {
  late DyslexiaSettings settings;

  @override
  void initState() {
    super.initState();
    settings = dyslexiaSettings;
    // Initialize temp values with saved settings
    settings.initializeTempValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFBF5),
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            settings.discardChanges();
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
            ),
            child: const Icon(
              Icons.arrow_back,
              color: Color(0xFF1F1F2E),
              size: 28,
            ),
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Dyslexia Mode',
          style: TextStyle(
            color: Color(0xFF1F1F2E),
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              // Live Preview Section
              _buildLivePreviewSection(),
              const SizedBox(height: 24),
              // Typography Section
              _buildTypographySection(),
              const SizedBox(height: 24),
              // Visual Comfort Section
              _buildVisualComfortSection(),
              const SizedBox(height: 24),
              // Reading Assists Section
              _buildReadingAssistsSection(),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomActionBar(),
    );
  }

  Widget _buildLivePreviewSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Live Preview',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F1F2E),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.visibility,
                    color: Color(0xFF10B981),
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    'Active',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF10B981),
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: settings.tempBackgroundColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFF7C3AED).withOpacity(0.2),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Reading is easier with the right tools.',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: settings.getTempLetterSpacingValue(),
                  height: settings.getTempLineHeightValue(),
                  color: const Color(0xFF1F1F2E),
                  fontFamily: settings.tempFontFamily,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'The quick brown fox jumps over the lazy dog. Dyslexia mode helps reduce visual crowding and improves focus.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: settings.getTempLetterSpacingValue(),
                  height: settings.getTempLineHeightValue(),
                  color: const Color(0xFF374151),
                  fontFamily: settings.tempFontFamily,
                  wordSpacing: 0.1,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Center(
          child: Text(
            'Preview updates automatically',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Color(0xFF9CA3AF),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTypographySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Typography',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F1F2E),
          ),
        ),
        const SizedBox(height: 16),
        // Font Family Selector
        const Text(
          'Font Family',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color(0xFF5A5A75),
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildFontButton('Lexend'),
              const SizedBox(width: 12),
              _buildFontButton('OpenDyslexic'),
              const SizedBox(width: 12),
              _buildFontButton('Georgia'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFontButton(String fontName) {
    bool isSelected = settings.tempFontFamily == fontName;
    return GestureDetector(
      onTap: () {
        setState(() {
          settings.setTempFontFamily(fontName);
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF7C3AED) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? null
              : Border.all(
                  color: Colors.grey[200]!,
                  width: 2,
                ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF7C3AED).withOpacity(0.2),
                    blurRadius: 12,
                  )
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                  )
                ],
        ),
        child: Row(
          children: [
            const Icon(
              Icons.text_fields,
              color: Color(0xFF7C3AED),
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              fontName,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : const Color(0xFF1F1F2E),
                fontFamily: fontName,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVisualComfortSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Visual Comfort',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F1F2E),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.grey[200]!,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 8,
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Background Tint',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5A5A75),
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildColorButton('White', const Color(0xFFFFFFFF)),
                  _buildColorButton('Cream', const Color(0xFFFFFBF5)),
                  _buildColorButton('Blue', const Color(0xFFEBF8FF)),
                  _buildColorButton('Yellow', const Color(0xFFFEFCE8)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildColorButton(String label, Color color) {
    bool isSelected = settings.tempBackgroundColor == color;
    return GestureDetector(
      onTap: () {
        setState(() {
          settings.setTempBackgroundColor(color);
        });
      },
      child: Column(
        children: [
          Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected
                    ? const Color(0xFF7C3AED)
                    : Colors.grey[300]!,
                width: isSelected ? 3 : 2,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: const Color(0xFF7C3AED).withOpacity(0.2),
                        blurRadius: 12,
                      )
                    ]
                  : null,
            ),
            child: isSelected
                ? const Icon(
                    Icons.check,
                    color: Color(0xFF7C3AED),
                    size: 28,
                  )
                : null,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Color(0xFF5A5A75),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReadingAssistsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Text Adjustments',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F1F2E),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.grey[200]!,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 8,
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Letter Spacing Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.space_bar,
                        color: Color(0xFF9CA3AF),
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Letter Spacing',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F1F2E),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF7C3AED).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      settings.tempLetterSpacing > 0
                          ? 'Wide'
                          : 'Normal',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF7C3AED),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Slider(
                value: settings.tempLetterSpacing,
                min: 0,
                max: 100,
                onChanged: (value) {
                  setState(() {
                    settings.setTempLetterSpacing(value);
                  });
                },
                activeColor: const Color(0xFF7C3AED),
                inactiveColor: Colors.grey[200],
              ),
              const SizedBox(height: 24),
              // Line Spacing Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.format_line_spacing,
                        color: Color(0xFF9CA3AF),
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Line Spacing',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F1F2E),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF7C3AED).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '${settings.getTempLineHeightValue().toStringAsFixed(1)}x',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF7C3AED),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Slider(
                value: settings.tempLineHeight,
                min: 10,
                max: 30,
                onChanged: (value) {
                  setState(() {
                    settings.setTempLineHeight(value);
                  });
                },
                activeColor: const Color(0xFF7C3AED),
                inactiveColor: Colors.grey[200],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActionBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey[200]!,
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, -4),
          )
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () async {
                await settings.applySettings();
                if (!context.mounted) return;
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7C3AED),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.check_circle,
                    color: Colors.white,
                    size: 24,
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Apply Changes',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
