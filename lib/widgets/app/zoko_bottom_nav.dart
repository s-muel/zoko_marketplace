import 'package:flutter/material.dart';
import 'package:zoko_marketplace/core/navigation/app_navigation.dart';
import 'package:zoko_marketplace/core/theme/zoko_colors.dart';
import 'package:zoko_marketplace/core/theme/zoko_theme.dart';

class ZokoBottomNav extends StatelessWidget {
  const ZokoBottomNav({super.key, required this.selectedIndex});

  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    final themeColors = ZokoThemeColors.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 0, 18, 14),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: themeColors.card.withValues(alpha: 0.74),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: themeColors.border),
          boxShadow: [
            BoxShadow(
              color: themeColors.shadow,
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
                  color: isSelected ? themeColors.text : themeColors.mutedText,
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700,
                );
              }),
              iconTheme: WidgetStateProperty.resolveWith((states) {
                final isSelected = states.contains(WidgetState.selected);

                return IconThemeData(
                  color: isSelected ? ZokoColors.teal : themeColors.text,
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
                  icon: Icon(Icons.assignment_outlined),
                  selectedIcon: Icon(Icons.assignment_rounded),
                  label: 'Requests',
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
