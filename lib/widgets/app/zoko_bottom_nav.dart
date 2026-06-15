import 'package:flutter/material.dart';
import 'package:zoko_marketplace/core/theme/zoko_colors.dart';

class ZokoBottomNav extends StatelessWidget {
  const ZokoBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      height: 72,
      backgroundColor: Colors.white,
      indicatorColor: ZokoColors.teal.withValues(alpha: 0.12),
      selectedIndex: 0,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home_rounded, color: ZokoColors.teal),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.explore_outlined),
          selectedIcon: Icon(Icons.explore_rounded, color: ZokoColors.teal),
          label: 'Explore',
        ),
        NavigationDestination(
          icon: Icon(Icons.chat_bubble_outline_rounded),
          selectedIcon: Icon(Icons.chat_bubble_rounded, color: ZokoColors.teal),
          label: 'Inbox',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline_rounded),
          selectedIcon: Icon(Icons.person_rounded, color: ZokoColors.teal),
          label: 'Profile',
        ),
      ],
    );
  }
}
