import 'package:flutter/material.dart';
import 'package:zoko_marketplace/core/navigation/app_navigation.dart';
import 'package:zoko_marketplace/core/theme/zoko_colors.dart';

class ZokoBottomNav extends StatelessWidget {
  const ZokoBottomNav({super.key, required this.selectedIndex});

  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 0, 18, 14),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.22),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: Colors.white.withValues(alpha: 0.65)),
          boxShadow: [
            BoxShadow(
              color: ZokoColors.navy.withValues(alpha: 0.08),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: NavigationBarTheme(
            data: NavigationBarThemeData(
              height: 66,
              backgroundColor: Colors.transparent,
              indicatorColor: ZokoColors.teal.withValues(alpha: 0.13),
              labelTextStyle: WidgetStateProperty.resolveWith((states) {
                final isSelected = states.contains(WidgetState.selected);

                return TextStyle(
                  color: isSelected ? ZokoColors.navy : ZokoColors.textGrey,
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700,
                );
              }),
              iconTheme: WidgetStateProperty.resolveWith((states) {
                final isSelected = states.contains(WidgetState.selected);

                return IconThemeData(
                  color: isSelected ? ZokoColors.teal : ZokoColors.navy,
                  size: isSelected ? 23 : 21,
                );
              }),
            ),
            child: NavigationBar(
              selectedIndex: selectedIndex,
              backgroundColor: Colors.transparent,
              indicatorColor: ZokoColors.teal.withValues(alpha: 0.13),
              onDestinationSelected: (index) {
                if (index == selectedIndex) {
                  return;
                }
                AppNavigation.openTab(context, index);
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home_rounded),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.explore_outlined),
                  selectedIcon: Icon(Icons.explore_rounded),
                  label: 'Explore',
                ),
                NavigationDestination(
                  icon: Icon(Icons.chat_bubble_outline_rounded),
                  selectedIcon: Icon(Icons.chat_bubble_rounded),
                  label: 'Inbox',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person_outline_rounded),
                  selectedIcon: Icon(Icons.person_rounded),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
