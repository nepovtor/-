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
      GoRoute(path: splash, builder: (context, state) => const SplashPage()),
      GoRoute(path: login, builder: (context, state) => const LoginPage()),
      GoRoute(path: home, builder: (context, state) => const HomePage()),
      GoRoute(path: events, builder: (context, state) => const EventsPage()),
      GoRoute(path: tasks, builder: (context, state) => const TasksPage()),
      GoRoute(path: settings, builder: (context, state) => const SettingsPage()),
    ],
  );
}

