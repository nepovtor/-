import 'package:flutter/material.dart';

/// Basic home screen shown after launch.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Camp Leader')),
      body: const Center(
        child: Text('Welcome to camp management!'),
      ),
    );
  }
}

