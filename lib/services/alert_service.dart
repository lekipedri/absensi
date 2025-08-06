import 'package:flutter/material.dart';

class AlertService {
  static void showError(BuildContext context, String message, String title) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Tutup"),
          ),
        ],
      ),
    );
  }
}
