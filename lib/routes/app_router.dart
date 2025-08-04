import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/events_page.dart';
import '../core/home_page.dart';
import '../core/login_page.dart';
import '../core/settings_page.dart';
import '../core/splash_page.dart';
import '../core/tasks_page.dart';

/// Central router configuration using [GoRouter].
class AppRouter {
  static const splash = '/';
  static const login = '/login';
  static const home = '/home';
  static const events = '/events';
  static const tasks = '/tasks';
  static const settings = '/settings';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(
        path: splash,
        pageBuilder: (context, state) => _buildPage(state, const SplashPage()),
      ),
      GoRoute(
        path: login,
        pageBuilder: (context, state) => _buildPage(state, const LoginPage()),
      ),
      GoRoute(
        path: home,
        pageBuilder: (context, state) => _buildPage(state, const HomePage()),
      ),
      GoRoute(
        path: events,
        pageBuilder: (context, state) => _buildPage(state, const EventsPage()),
      ),
      GoRoute(
        path: tasks,
        pageBuilder: (context, state) => _buildPage(state, const TasksPage()),
      ),
      GoRoute(
        path: settings,
        pageBuilder: (context, state) => _buildPage(state, const SettingsPage()),
      ),
    ],
  );

  static CustomTransitionPage<void> _buildPage(
      GoRouterState state, Widget child) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}

