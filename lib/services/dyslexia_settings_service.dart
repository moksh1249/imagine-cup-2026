import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:study_buddy/common/dyslexia_settings.dart';

/// Service for managing dyslexia settings persistence with JSON file storage
class DyslexiaSettingsService {
  static final DyslexiaSettingsService _instance = DyslexiaSettingsService._internal();

  factory DyslexiaSettingsService() {
    return _instance;
  }

  DyslexiaSettingsService._internal();

  late File _settingsFile;
  bool _initialized = false;

  /// Initialize the service and load settings from file
  Future<void> initialize() async {
    if (_initialized) return;

    try {
      final directory = await getApplicationDocumentsDirectory();
      _settingsFile = File('${directory.path}/dyslexia_settings.json');
      
      // Load settings from file if it exists
      if (_settingsFile.existsSync()) {
        await loadSettingsFromFile();
      }
      
      _initialized = true;
    } catch (e) {
      print('Error initializing DyslexiaSettingsService: $e');
    }
  }

  /// Save settings to JSON file
  Future<void> saveSettingsToFile() async {
    try {
      if (!_initialized) await initialize();

      final settings = dyslexiaSettings;
      final jsonData = {
        'fontFamily': settings.fontFamily,
        'backgroundColor': settings.backgroundColor.value,
        'letterSpacing': settings.letterSpacing,
        'lineHeight': settings.lineHeight,
      };

      final jsonString = jsonEncode(jsonData);
      await _settingsFile.writeAsString(jsonString);
      print('Dyslexia settings saved to file');
    } catch (e) {
      print('Error saving dyslexia settings to file: $e');
    }
  }

  /// Load settings from JSON file
  Future<void> loadSettingsFromFile() async {
    try {
      if (!_initialized) await initialize();

      if (_settingsFile.existsSync()) {
        final jsonString = await _settingsFile.readAsString();
        final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;

        // Apply loaded settings using setter methods
        dyslexiaSettings.setSavedFontFamily(jsonData['fontFamily'] as String? ?? 'Lexend');
        dyslexiaSettings.setSavedBackgroundColor(Color(jsonData['backgroundColor'] as int? ?? 0xFFFFFBF5));
        dyslexiaSettings.setSavedLetterSpacing((jsonData['letterSpacing'] as num?)?.toDouble() ?? 0.0);
        dyslexiaSettings.setSavedLineHeight((jsonData['lineHeight'] as num?)?.toDouble() ?? 15.0);

        // Initialize temp values with loaded settings
        dyslexiaSettings.initializeTempValues();
        dyslexiaSettings.notifyListeners();
        
        print('Dyslexia settings loaded from file');
      }
    } catch (e) {
      print('Error loading dyslexia settings from file: $e');
    }
  }

  /// Get file path for debugging
  Future<String> getSettingsFilePath() async {
    if (!_initialized) await initialize();
    return _settingsFile.path;
  }

  /// Clear all settings (reset to defaults and delete file)
  Future<void> clearSettings() async {
    try {
      if (!_initialized) await initialize();

      if (_settingsFile.existsSync()) {
        await _settingsFile.delete();
      }
      print('Dyslexia settings file deleted');
    } catch (e) {
      print('Error clearing dyslexia settings: $e');
    }
  }

  /// Export settings as JSON string
  String exportSettingsAsJson() {
    final settings = dyslexiaSettings;
    final jsonData = {
      'fontFamily': settings.fontFamily,
      'backgroundColor': settings.backgroundColor.value,
      'letterSpacing': settings.letterSpacing,
      'lineHeight': settings.lineHeight,
      'exportDate': DateTime.now().toIso8601String(),
    };
    return jsonEncode(jsonData);
  }

  /// Import settings from JSON string
  Future<void> importSettingsFromJson(String jsonString) async {
    try {
      final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;

      dyslexiaSettings.setSavedFontFamily(jsonData['fontFamily'] as String? ?? 'Lexend');
      dyslexiaSettings.setSavedBackgroundColor(Color(jsonData['backgroundColor'] as int? ?? 0xFFFFFBF5));
      dyslexiaSettings.setSavedLetterSpacing((jsonData['letterSpacing'] as num?)?.toDouble() ?? 0.0);
      dyslexiaSettings.setSavedLineHeight((jsonData['lineHeight'] as num?)?.toDouble() ?? 15.0);

      dyslexiaSettings.initializeTempValues();
      await saveSettingsToFile();
      dyslexiaSettings.notifyListeners();
      
      print('Dyslexia settings imported successfully');
    } catch (e) {
      print('Error importing dyslexia settings: $e');
    }
  }
}

// Singleton instance
final dyslexiaSettingsService = DyslexiaSettingsService();
