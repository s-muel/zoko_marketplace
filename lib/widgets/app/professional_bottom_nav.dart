import 'package:flutter/material.dart';
import 'package:zoko_marketplace/core/theme/zoko_colors.dart';
import 'package:zoko_marketplace/core/theme/zoko_theme.dart';
import 'package:zoko_marketplace/screens/professional/professional_dashboard_screen.dart';
import 'package:zoko_marketplace/screens/professional/professional_jobs_screen.dart';
import 'package:zoko_marketplace/screens/professional/professional_profile_screen.dart'
    as professional_owner;
import 'package:zoko_marketplace/screens/professional/professional_proposals_screen.dart';

class ProfessionalBottomNav extends StatelessWidget {
  const ProfessionalBottomNav({super.key, required this.selectedIndex});

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

                final routeName = switch (index) {
                  0 => ProfessionalDashboardScreen.routeName,
                  1 => ProfessionalJobsScreen.routeName,
                  2 => ProfessionalProposalsScreen.routeName,
                  3 => professional_owner.ProfessionalProfileScreen.routeName,
                  _ => null,
                };

                if (routeName == null) {
                  return;
                }

                Navigator.of(context).pushNamedAndRemoveUntil(
                  routeName,
                  (route) => false,
                );
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.dashboard_outlined),
                  selectedIcon: Icon(Icons.dashboard_rounded),
                  label: 'Dashboard',
                ),
                NavigationDestination(
                  icon: Icon(Icons.work_outline_rounded),
                  selectedIcon: Icon(Icons.work_rounded),
                  label: 'Jobs',
                ),
                NavigationDestination(
                  icon: Icon(Icons.send_outlined),
                  selectedIcon: Icon(Icons.send_rounded),
                  label: 'Proposals',
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
