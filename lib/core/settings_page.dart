import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/auth_provider.dart';
import '../providers/theme_provider.dart';
import '../routes/app_router.dart';

/// Simple settings screen allowing the user to choose the theme.
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>();
    final auth = context.watch<AuthProvider>();
    final mode = theme.themeMode;
    final tiles = <Widget>[
      RadioListTile<ThemeMode>(
        title: const Text('System'),
        value: ThemeMode.system,
        groupValue: mode,
        onChanged: (m) {
          if (m != null) theme.setThemeMode(m);
        },
      ),
      RadioListTile<ThemeMode>(
        title: const Text('Light'),
        value: ThemeMode.light,
        groupValue: mode,
        onChanged: (m) {
          if (m != null) theme.setThemeMode(m);
        },
      ),
      RadioListTile<ThemeMode>(
        title: const Text('Dark'),
        value: ThemeMode.dark,
        groupValue: mode,
        onChanged: (m) {
          if (m != null) theme.setThemeMode(m);
        },
      ),
    ];

    final isAdmin =
        auth.currentUser?.roles.contains(UserRole.admin) ?? false;
    if (isAdmin) {
      tiles.add(
        ListTile(
          title: const Text('Manage Users'),
          onTap: () => context.push(AppRouter.adminUsers),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(children: tiles),
    );
  }
}

