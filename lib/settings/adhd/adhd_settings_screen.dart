import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_buddy/common/common_app_bar.dart';

class ADHDSettingsScreen extends StatefulWidget {
  const ADHDSettingsScreen({super.key});

  @override
  State<ADHDSettingsScreen> createState() => _ADHDSettingsScreenState();
}

class _ADHDSettingsScreenState extends State<ADHDSettingsScreen> {
  bool enableADHDMode = true;
  int focusDuration = 25; // minutes
  int breakDuration = 5; // minutes
  bool enableNotifications = true;
  bool enableSoundEffects = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: CommonAppBar(
          title: 'ADHD Settings',
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
              // Main toggle
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ADHD Focus Mode',
                          style: TextStyle(
                            color: Color(0xFF130e1b),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Lexend',
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Reduces distractions and improves focus',
                          style: TextStyle(
                            color: Color(0xFF6b7280),
                            fontSize: 12,
                            fontFamily: 'Lexend',
                          ),
                        ),
                      ],
                    ),
                    Switch(
                      value: enableADHDMode,
                      onChanged: (value) {
                        setState(() => enableADHDMode = value);
                      },
                      activeThumbColor: const Color(0xFF10B981),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Focus duration settings
              const Text(
                'Session Settings',
                style: TextStyle(
                  color: Color(0xFF130e1b),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lexend',
                ),
              ),
              const SizedBox(height: 16),
              _buildDurationSetting(
                'Focus Duration',
                '$focusDuration minutes',
                'Time for focused study',
                onIncrement: () {
                  setState(() => focusDuration += 5);
                },
                onDecrement: () {
                  if (focusDuration > 5) setState(() => focusDuration -= 5);
                },
              ),
              const SizedBox(height: 16),
              _buildDurationSetting(
                'Break Duration',
                '$breakDuration minutes',
                'Time for rest and refresh',
                onIncrement: () {
                  setState(() => breakDuration += 5);
                },
                onDecrement: () {
                  if (breakDuration > 5) setState(() => breakDuration -= 5);
                },
              ),
              const SizedBox(height: 32),
              // Notifications
              const Text(
                'Reminders & Notifications',
                style: TextStyle(
                  color: Color(0xFF130e1b),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lexend',
                ),
              ),
              const SizedBox(height: 16),
              _buildToggleSetting(
                'Break Reminders',
                'Get notified when it\'s time for a break',
                enableNotifications,
                (value) {
                  setState(() => enableNotifications = value);
                },
              ),
              const SizedBox(height: 12),
              _buildToggleSetting(
                'Sound Effects',
                'Enable subtle notification sounds',
                enableSoundEffects,
                (value) {
                  setState(() => enableSoundEffects = value);
                },
              ),
              const SizedBox(height: 32),
              // Visual settings
              const Text(
                'Visual Preferences',
                style: TextStyle(
                  color: Color(0xFF130e1b),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lexend',
                ),
              ),
              const SizedBox(height: 16),
              _buildOptionSetting(
                '✓ Minimal interface',
                'Hide unnecessary elements',
              ),
              const SizedBox(height: 12),
              _buildOptionSetting(
                '✓ Large text',
                'Easier to read content',
              ),
              const SizedBox(height: 12),
              _buildOptionSetting(
                '✓ High contrast',
                'Better visibility',
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDurationSetting(
    String title,
    String value,
    String description, {
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF130e1b),
                      fontSize: 14,
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
              Text(
                value,
                style: const TextStyle(
                  color: Color(0xFF7e37f1),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lexend',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[100],
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  onPressed: onDecrement,
                  child: const Text('-'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7e37f1),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  onPressed: onIncrement,
                  child: const Text('+'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildToggleSetting(
    String title,
    String description,
    bool value,
    Function(bool) onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF130e1b),
                    fontSize: 14,
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
          Switch(
            value: value,
            onChanged: (val) => onChanged(val),
            activeThumbColor: const Color(0xFF10B981),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionSetting(String title, String description) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF10B981).withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFF10B981).withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF130e1b),
              fontSize: 14,
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
    );
  }
}
