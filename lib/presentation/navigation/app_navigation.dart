import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationApp {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static void pathTo(BuildContext context, String path, {Object? extra}) {
    context.go(path, extra: extra);
  }

  static void routeTo(BuildContext context, String name, {Object? extra}) {
    context.goNamed(name, extra: extra);
  }

  static void replaceWith(BuildContext context, String name, {Object? extra}) {
    context.pushReplacementNamed(name, extra: extra);
  }

  static void pop(BuildContext context) {
    Navigator.of(context).pop();
  }
}
