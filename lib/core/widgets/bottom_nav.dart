import 'package:flutter/material.dart';

import '../../routes/app_router.dart';
import 'package:go_router/go_router.dart';

/// Bottom navigation bar used across pages for quick navigation.
class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  const CustomBottomNav({super.key, required this.currentIndex});

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(AppRouter.home);
        break;
      case 1:
        context.go(AppRouter.events);
        break;
      case 2:
        context.go(AppRouter.tasks);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (i) => _onTap(context, i),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Events'),
        BottomNavigationBarItem(icon: Icon(Icons.check), label: 'Tasks'),
      ],
    );
  }
}
