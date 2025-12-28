import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DyslexiaSettings extends ChangeNotifier {
  // Typography Settings
  String _fontFamily = 'Lexend'; // Default: Lexend
  
  // Visual Comfort Settings
  Color _backgroundColor = const Color(0xFFFFFBF5); // Default: Cream
  
  // Letter Spacing
  double _letterSpacing = 0.0; // Default: 0.0
  
  // Line Height (slider range 10-30 = line height 1.0-3.0)
  double _lineHeight = 15.0; // Default: 15 (represents 1.5x)
  
  // Temporary values for preview (not saved until applied)
  String _tempFontFamily = 'Lexend';
  Color _tempBackgroundColor = const Color(0xFFFFFBF5);
  double _tempLetterSpacing = 0.0;
  double _tempLineHeight = 15.0;
  String get fontFamily => _fontFamily;
  Color get backgroundColor => _backgroundColor;
  double get letterSpacing => _letterSpacing;
  double get lineHeight => _lineHeight;

  // Getters for temporary settings (being edited)
  String get tempFontFamily => _tempFontFamily;
  Color get tempBackgroundColor => _tempBackgroundColor;
  double get tempLetterSpacing => _tempLetterSpacing;
  double get tempLineHeight => _tempLineHeight;

  // Initialize temp values from saved settings
  void initializeTempValues() {
    _tempFontFamily = _fontFamily;
    _tempBackgroundColor = _backgroundColor;
    _tempLetterSpacing = _letterSpacing;
    _tempLineHeight = _lineHeight;
    notifyListeners();
  }

  // Setters for temporary values (for preview)
  void setTempFontFamily(String font) {
    _tempFontFamily = font;
    notifyListeners();
  }

  void setTempBackgroundColor(Color color) {
    _tempBackgroundColor = color;
    notifyListeners();
  }

  void setTempLetterSpacing(double spacing) {
    _tempLetterSpacing = spacing;
    notifyListeners();
  }

  void setTempLineHeight(double height) {
    _tempLineHeight = height;
    notifyListeners();
  }

  // Internal setters for saved values (used by DyslexiaSettingsService)
  void setSavedFontFamily(String font) {
    _fontFamily = font;
    notifyListeners();
  }

  void setSavedBackgroundColor(Color color) {
    _backgroundColor = color;
    notifyListeners();
  }

  void setSavedLetterSpacing(double spacing) {
    _letterSpacing = spacing;
    notifyListeners();
  }

  void setSavedLineHeight(double height) {
    _lineHeight = height;
    notifyListeners();
  }

  // Apply temporary settings to saved settings
  Future<void> applySettings() async {
    _fontFamily = _tempFontFamily;
    _backgroundColor = _tempBackgroundColor;
    _letterSpacing = _tempLetterSpacing;
    _lineHeight = _tempLineHeight;
    
    await _saveSettings();
    notifyListeners();
  }

  // Discard temporary settings
  void discardChanges() {
    initializeTempValues();
  }

  // Save settings to SharedPreferences
  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    
    await prefs.setString('dyslexia_fontFamily', _fontFamily);
    await prefs.setInt('dyslexia_backgroundColor', _backgroundColor.value);
    await prefs.setDouble('dyslexia_letterSpacing', _letterSpacing);
    await prefs.setDouble('dyslexia_lineHeight', _lineHeight);
  }

  // Load settings from SharedPreferences
  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    
    _fontFamily = prefs.getString('dyslexia_fontFamily') ?? 'Lexend';
    _backgroundColor = Color(prefs.getInt('dyslexia_backgroundColor') ?? 0xFFFFFBF5);
    _letterSpacing = prefs.getDouble('dyslexia_letterSpacing') ?? 0.0;
    _lineHeight = prefs.getDouble('dyslexia_lineHeight') ?? 15.0;
    
    // Initialize temp values with saved settings
    initializeTempValues();
    notifyListeners();
  }

  // Reset to defaults
  Future<void> resetToDefaults() async {
    _fontFamily = 'Lexend';
    _backgroundColor = const Color(0xFFFFFBF5);
    _letterSpacing = 0.0;
    _lineHeight = 15.0;
    
    initializeTempValues();
    await _saveSettings();
    notifyListeners();
  }

  // Get letter spacing value for text
  double getLetterSpacingValue() {
    // Convert slider value (0-100) to letter spacing (0-0.1)
    return (_letterSpacing / 100) * 0.5;
  }

  // Get line height value for text
  double getLineHeightValue() {
    // Convert slider value (10-30) to line height (1.0-3.0)
    return 1.0 + ((_lineHeight - 10) / 20) * 3.0;
  }

  // Get temp letter spacing value for preview
  double getTempLetterSpacingValue() {
    return (_tempLetterSpacing / 100) * 0.5;
  }

  // Get temp line height value for preview
  double getTempLineHeightValue() {
    return 1.0 + ((_tempLineHeight - 10) / 20) * 3.0;
  }
}

// Singleton instance
final dyslexiaSettings = DyslexiaSettings();
