import 'package:flutter/material.dart';
import 'package:quan_ly_ci_co/presentation/navigation/app_navigation.dart';
import 'package:quan_ly_ci_co/presentation/navigation/router.dart';
import 'package:quan_ly_ci_co/core/utils/toast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      restorationScopeId: 'app',
      builder: (context, child) {
        return Overlay(
          initialEntries: [
            OverlayEntry(builder: (context) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ToastApp.init(
                    NavigationApp.navigatorKey.currentContext ?? context);
              });
              return child!;
            }),
          ],
        );
      },
      debugShowCheckedModeBanner: false,
      routerConfig: appGoRouter,
    );
  }
}
