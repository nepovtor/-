import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../providers/auth_provider.dart';
import '../routes/app_router.dart';
import 'widgets/bottom_nav.dart';
import 'widgets/custom_button.dart';

/// Basic home screen shown after launch.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camp Leader'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.go(AppRouter.settings),
          )
        ],
      ),
      bottomNavigationBar: const CustomBottomNav(currentIndex: 0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to camp management!'),
            const SizedBox(height: 16),
            CustomButton(
              label: 'Logout',
              onPressed: () {
                context.read<AuthProvider>().logout();
                context.go(AppRouter.login);
              },
            ),
          ],
        ),
      ),
    );
  }
}
