import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  final Widget child;

  const DashboardScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(padding: const EdgeInsets.all(20), child: child));
  }
}
