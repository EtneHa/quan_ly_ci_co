import 'package:flutter/material.dart';
import 'package:quan_ly_ci_co/core/styles/text_styles_app.dart';

class OutlinedButtonApp extends StatelessWidget {
  const OutlinedButtonApp({
    super.key,
    this.child,
    this.label,
    required this.onPressed,
  });
  final Widget? child;
  final String? label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          elevation: 3,
          backgroundColor: Colors.white,
          shadowColor: Colors.black.withOpacity(0.2),
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        ),
        child: child ??
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 22),
              child: Text(
                (label ?? '').toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStylesApp.subtitle1(color: Colors.white),
              ),
            ));
  }
}
