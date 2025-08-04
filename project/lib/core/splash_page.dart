import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../providers/auth_provider.dart';
import '../routes/app_router.dart';

/// Splash screen shown while the app initializes.
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double _opacity = 0;
  @override
  void initState() {
    super.initState();
    _startAnimation();
    _init();
  }

  void _startAnimation() {
    Future<void>.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() {
          _opacity = 1;
        });
      }
    });
  }

  Future<void> _init() async {
    // Simulate asynchronous initialization such as loading data
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    final auth = context.read<AuthProvider>();
    final nextRoute = auth.isLoggedIn ? AppRouter.home : AppRouter.login;
    context.go(nextRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedOpacity(
              opacity: _opacity,
              duration: const Duration(milliseconds: 800),
              child: const FlutterLogo(size: 120),
            ),
            const SizedBox(height: 24),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

