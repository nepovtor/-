import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'providers/event_provider.dart';
import 'providers/task_provider.dart';
import 'routes/app_routes.dart';
import 'theme.dart';

void main() {
  runApp(const CampLeaderApp());
}

/// Root widget for the camp leader application.
class CampLeaderApp extends StatelessWidget {
  const CampLeaderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => EventProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: MaterialApp(
        title: 'Camp Leader',
        theme: AppTheme.lightTheme,
        routes: AppRoutes.routes,
        initialRoute: AppRoutes.login,
      ),
    );
  }
}
