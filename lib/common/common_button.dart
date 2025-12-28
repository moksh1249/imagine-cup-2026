import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double? width;
  final double? height;
  final bool isOutlined;
  final IconData? icon;
  final double borderRadius;

  const CommonButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = const Color(0xFF7e37f1),
    this.textColor = Colors.white,
    this.width,
    this.height,
    this.isOutlined = false,
    this.icon,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    final buttonContent = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(icon, color: isOutlined ? backgroundColor : textColor),
          const SizedBox(width: 8),
        ],
        Text(
          text,
          style: TextStyle(
            color: isOutlined ? backgroundColor : textColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lexend',
          ),
        ),
      ],
    );

    final widget = SizedBox(
      width: width,
      height: height,
      child: isOutlined
          ? OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                side: BorderSide(color: backgroundColor, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
              onPressed: onPressed,
              child: buttonContent,
            )
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
              onPressed: onPressed,
              child: buttonContent,
            ),
    );

    return widget;
  }
}
