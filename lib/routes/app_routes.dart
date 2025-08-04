import 'package:flutter/material.dart';

import '../core/home_page.dart';

/// Central definition of named routes used in the application.
class AppRoutes {
  static const home = '/';

  static final Map<String, WidgetBuilder> routes = {
    home: (context) => const HomePage(),
  };
}

