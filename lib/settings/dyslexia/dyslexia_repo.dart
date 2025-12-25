import 'package:flutter/material.dart';
import 'package:study_buddy/common/dyslexia_settings.dart';

/// Repository for managing dyslexia settings persistence and operations
class DyslexiaRepository {
  final DyslexiaSettings settings = dyslexiaSettings;

  /// Save current settings (can be extended for persistence)
  Future<void> saveSettings() async {
    // TODO: Implement persistent storage (SharedPreferences, local database, etc.)
    // For now, settings are stored in memory
    return Future.value();
  }

  /// Load saved settings
  Future<void> loadSettings() async {
    // TODO: Implement loading from persistent storage
    return Future.value();
  }

  /// Get all current settings as a map
  Map<String, dynamic> getSettingsMap() {
    return {
      'fontFamily': settings.fontFamily,
      'backgroundColor': settings.backgroundColor.value,
      'letterSpacing': settings.letterSpacing,
      'lineHeight': settings.lineHeight,
    };
  }

  /// Apply settings with specific values
  void applySettings({
    String? fontFamily,
    Color? backgroundColor,
    double? letterSpacing,
    double? lineHeight,
  }) {
    if (fontFamily != null) {
      settings.setTempFontFamily(fontFamily);
    }
    if (backgroundColor != null) {
      settings.setTempBackgroundColor(backgroundColor);
    }
    if (letterSpacing != null) {
      settings.setTempLetterSpacing(letterSpacing);
    }
    if (lineHeight != null) {
      settings.setTempLineHeight(lineHeight);
    }
  }

  /// Reset all settings to defaults
  void resetSettings() {
    settings.resetToDefaults();
  }

  /// Get text style with dyslexia settings applied
  TextStyle getAppliedTextStyle({
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.normal,
    Color color = const Color(0xFF1F1F2E),
    double? height,
  }) {
    return TextStyle(
      fontFamily: settings.fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: settings.getLetterSpacingValue(),
      height: height ?? settings.getLineHeightValue(),
    );
  }

  /// Check if dyslexia mode is active (if any settings differ from defaults)
  bool isDyslexiaModeActive() {
    return settings.fontFamily != 'Lexend' ||
        settings.backgroundColor != const Color(0xFFFFFBF5) ||
        settings.letterSpacing != 0.0 ||
        settings.lineHeight != 1.5;
  }

  /// Get background color for UI elements
  Color getBackgroundColor() {
    return settings.backgroundColor;
  }

  /// Get font family
  String getFontFamily() {
    return settings.fontFamily;
  }

  /// Get letter spacing value
  double getLetterSpacingValue() {
    return settings.getLetterSpacingValue();
  }

  /// Get line height value
  double getLineHeightValue() {
    return settings.getLineHeightValue();
  }
}

// Singleton instance
final dyslexiaRepository = DyslexiaRepository();
