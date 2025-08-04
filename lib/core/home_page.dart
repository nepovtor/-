import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../routes/app_routes.dart';

/// Basic home screen shown after launch.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Camp Leader')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to camp management!'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.events),
              child: const Text('View Events'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.tasks),
              child: const Text('View Tasks'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                context.read<AuthProvider>().logout();
                Navigator.pushReplacementNamed(
                    context, AppRoutes.login);
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}

