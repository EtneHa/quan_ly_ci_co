import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastApp {
  static late FToast fToast;

  static void init(BuildContext context) {
    fToast = FToast();
    fToast.init(context);
  }

  static void showError(String message) {
    _showToast(
      message,
      const Icon(Icons.close, color: Colors.white, size: 20),
      Colors.red,
    );
  }

  static void showSuccess(String message) {
    _showToast(
      message,
      const Icon(Icons.check_circle, color: Colors.white, size: 20),
      Colors.green,
    );
  }

  static void showWarning(String message) {
    _showToast(
      message,
      const Icon(Icons.warning, color: Colors.white, size: 20),
      Colors.orange,
    );
  }

  static void _showToast(String message, Icon icon, Color backgroundColor) {
    fToast.showToast(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: backgroundColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const SizedBox(width: 12.0),
            Expanded(
                child: Text(
              message,
              style: const TextStyle(color: Colors.white),
              overflow: TextOverflow.ellipsis,
            )),
          ],
        ),
      ),
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
  }
}
