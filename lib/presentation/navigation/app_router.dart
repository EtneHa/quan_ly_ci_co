import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quan_ly_ci_co/presentation/navigation/app_navigation.dart';
import 'package:quan_ly_ci_co/presentation/screen/dashboard/logger/logger_screen.dart';
import 'package:quan_ly_ci_co/presentation/screen/dashboard/navigation_screen.dart';
import 'package:quan_ly_ci_co/presentation/screen/dashboard/bangcong/bangcong_screen.dart';
import 'package:quan_ly_ci_co/presentation/screen/dashboard/user/user_screen.dart';
import 'package:quan_ly_ci_co/presentation/screen/launching/page_not_found_screen.dart';
import 'package:quan_ly_ci_co/presentation/screen/launching/splash_screen.dart';
import 'package:quan_ly_ci_co/presentation/screen/sign-in/cubit/sign_in_cubit.dart';
import 'package:quan_ly_ci_co/presentation/screen/sign-in/sign_in_screen.dart';

final GoRouter appGoRouter = GoRouter(
  navigatorKey: NavigationApp.navigatorKey,
  restorationScopeId: 'app',
  routerNeglect: false,
  initialLocation: '/',
  onException: (context, state, router) {
    router.goNamed('page-not-found', extra: state.uri.toString());
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    _dashboardRoute,
    GoRoute(
      name: 'sign-in',
      path: '/sign-in',
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider(
          create: (context) => SignInCubit(),
          child: const SignInScreen(),
        );
      },
    ),
    GoRoute(
      name: 'page-not-found',
      path: '/page-not-found',
      builder: (BuildContext context, GoRouterState state) {
        return PageNotFoundScreen(url: state.extra as String? ?? '');
      },
    ),
  ],
);

final _dashboardRoute = StatefulShellRoute.indexedStack(
  parentNavigatorKey: NavigationApp.navigatorKey,
  builder: (context, state, child) {
    return NavigationScreen(child: child);
  },
  branches: [
    StatefulShellBranch(
      navigatorKey: GlobalKey<NavigatorState>(),
      routes: [
        GoRoute(
          name: 'dashboard',
          path: '/dashboard',
          redirect: (_, __) => '/dashboard/user',
        ),
      ],
    ),
    StatefulShellBranch(
      navigatorKey: GlobalKey<NavigatorState>(),
      routes: [
        GoRoute(
          name: 'user',
          path: '/dashboard/user',
          builder: (context, state) {
            return UserScreen();
          },
        ),
      ],
    ),
    StatefulShellBranch(
      navigatorKey: GlobalKey<NavigatorState>(),
      routes: [
        GoRoute(
          name: 'logger',
          path: '/dashboard/logger',
          builder: (context, state) {
            return LoggerScreen();
          },
        ),
      ],
    ),
    StatefulShellBranch(
      navigatorKey: GlobalKey<NavigatorState>(),
      routes: [
        GoRoute(
          name: 'bangcong',
          path: '/bangcong',
          builder: (context, state) {
            return BangCongScreen();
          },
        ),
      ],
    ),
  ],
);
