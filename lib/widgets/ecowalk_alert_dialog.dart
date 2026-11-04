import 'package:flutter/material.dart';

class EcoWalkAlertDialog extends StatelessWidget {
  const EcoWalkAlertDialog({
    super.key,
    required this.title,
    required this.message,
    this.cancelText = 'Batal',
    this.confirmText = 'Lanjut',
    this.confirmColor = const Color(0xFF1E6056),
  });

  final String title;
  final String message;
  final String cancelText;
  final String confirmText;
  final Color confirmColor;

  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String message,
    String cancelText = 'Batal',
    String confirmText = 'Lanjut',
    Color confirmColor = const Color(0xFF1E6056),
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => EcoWalkAlertDialog(
        title: title,
        message: message,
        cancelText: cancelText,
        confirmText: confirmText,
        confirmColor: confirmColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          style: TextButton.styleFrom(foregroundColor: Colors.grey.shade700),
          child: Text(cancelText),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, true),
          style: ElevatedButton.styleFrom(
            backgroundColor: confirmColor,
            foregroundColor: Colors.white,
          ),
          child: Text(confirmText),
        ),
      ],
    );
  }
}
