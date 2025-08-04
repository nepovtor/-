import 'package:flutter/material.dart';
import 'routes/app_routes.dart';
import 'screens/dashboard/dashboard_screen.dart';

void main() {
  runApp(const CampLeaderApp());
}

class CampLeaderApp extends StatelessWidget {
  const CampLeaderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camp Leader',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.dashboard,
      routes: {
        AppRoutes.dashboard: (context) => const DashboardScreen(),
      },
    );
  }
}
