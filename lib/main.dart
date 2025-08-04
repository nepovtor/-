import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:firebase_core/firebase_core.dart';

import 'providers/auth_provider.dart';
import 'providers/event_provider.dart';
import 'providers/task_provider.dart';
import 'routes/app_router.dart';
import 'theme.dart';
import 'providers/theme_provider.dart';
import 'services/notification_service.dart';
import 'providers/admin_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SentryFlutter.init(
    (options) {
      options.dsn = 'YOUR_DSN_HERE';
    },
    appRunner: () async {
      await Firebase.initializeApp();
      await NotificationService().init();
      runApp(const CampLeaderApp());
    },
  );
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
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AdminProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, theme, _) {
          return MaterialApp.router(
            title: 'Camp Leader',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: theme.themeMode,
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
