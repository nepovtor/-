import 'package:flutter/material.dart';

import '../core/events_page.dart';
import '../core/home_page.dart';
import '../core/login_page.dart';
import '../core/tasks_page.dart';
import '../core/splash_page.dart';

/// Central definition of named routes used in the application.
class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const home = '/home';
  static const events = '/events';
  static const tasks = '/tasks';

  static final Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashPage(),
    login: (context) => const LoginPage(),
    home: (context) => const HomePage(),
    events: (context) => const EventsPage(),
    tasks: (context) => const TasksPage(),
  };
}

