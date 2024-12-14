import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:quan_ly_ci_co/presentation/navigation/app_navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _navigateToHome();
    });
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 300), () {});
    if (!mounted) return;
    try {
      NavigationApp.replaceWith(
          NavigationApp.navigatorKey.currentContext!, 'dashboard');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
