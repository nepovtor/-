import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../routes/app_routes.dart';

/// Splash screen shown while the app initializes.
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    // Simulate asynchronous initialization such as loading data
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    final auth = context.read<AuthProvider>();
    final nextRoute = auth.isLoggedIn ? AppRoutes.home : AppRoutes.login;
    Navigator.pushReplacementNamed(context, nextRoute);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

