import 'package:flutter/material.dart';
import 'package:zoko_marketplace/core/theme/zoko_colors.dart';
import 'package:zoko_marketplace/screens/admin/admin_dashboard_screen.dart';
import 'package:zoko_marketplace/screens/auth/auth_welcome_screen.dart';
import 'package:zoko_marketplace/widgets/app/zoko_bottom_nav.dart';
import 'package:zoko_marketplace/widgets/shared/responsive_page.dart';

class ClientProfileScreen extends StatelessWidget {
  const ClientProfileScreen({super.key});

  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: ResponsivePage(
          maxWidth: 980,
          child: ListView(
            children: const [
              _ProfileHeader(),
              SizedBox(height: 18),
              _StatsPanel(),
              SizedBox(height: 18),
              _QuickActionsPanel(),
              SizedBox(height: 18),
              _SettingsPanel(),
              SizedBox(height: 92),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const ZokoBottomNav(selectedIndex: 3),
      backgroundColor: ZokoColors.canvas,
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ZokoColors.navy,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: ZokoColors.navy.withValues(alpha: 0.14),
            blurRadius: 22,
            offset: const Offset(0, 11),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: ZokoColors.teal.withValues(alpha: 0.16),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
            ),
            child: const Center(
              child: Text(
                'AK',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Akosua K.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'akosua@example.com',
                  style: TextStyle(
                    color: Color(0xFFC9D5DD),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 10),
                _AccountTypePill(),
              ],
            ),
          ),
          const Icon(Icons.edit_rounded, color: ZokoColors.green),
        ],
      ),
    );
  }
}

class _AccountTypePill extends StatelessWidget {
  const _AccountTypePill();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: ZokoColors.green.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text(
        'Client account',
        style: TextStyle(
          color: ZokoColors.green,
          fontSize: 12,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class _StatsPanel extends StatelessWidget {
  const _StatsPanel();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 640;

        final stats = const [
          _ProfileStat(label: 'Saved pros', value: '8', icon: Icons.bookmark_rounded),
          _ProfileStat(label: 'Requests', value: '3', icon: Icons.assignment_rounded),
          _ProfileStat(label: 'Active', value: '2', icon: Icons.timelapse_rounded),
          _ProfileStat(label: 'Completed', value: '5', icon: Icons.verified_rounded),
        ];

        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: isWide ? 4 : 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: isWide ? 1.28 : 1.45,
          children: stats,
        );
      },
    );
  }
}

class _ProfileStat extends StatelessWidget {
  const _ProfileStat({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: ZokoColors.teal),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              color: ZokoColors.navy,
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: const TextStyle(
              color: ZokoColors.textGrey,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionsPanel extends StatelessWidget {
  const _QuickActionsPanel();

  @override
  Widget build(BuildContext context) {
    return _ProfileSection(
      title: 'Quick actions',
      children: const [
        _ProfileAction(
          icon: Icons.edit_note_rounded,
          title: 'Edit profile',
          subtitle: 'Update your name, email, and account details',
        ),
        _ProfileAction(
          icon: Icons.bookmark_border_rounded,
          title: 'Saved professionals',
          subtitle: 'View professionals you want to hire later',
        ),
        _ProfileAction(
          icon: Icons.receipt_long_rounded,
          title: 'Payments and invoices',
          subtitle: 'See invoices from Zoko admin',
        ),
      ],
    );
  }
}

class _SettingsPanel extends StatelessWidget {
  const _SettingsPanel();

  @override
  Widget build(BuildContext context) {
    return _ProfileSection(
      title: 'Settings',
      children: [
        _ProfileAction(
          icon: Icons.admin_panel_settings_rounded,
          title: 'Admin dashboard',
          subtitle: 'Review requests, quotes, invoices, and job progress',
          color: ZokoColors.navy,
          onTap: () {
            Navigator.of(context).pushNamed(AdminDashboardScreen.routeName);
          },
        ),
        const Divider(height: 20, color: ZokoColors.softGrey),
        const _ProfileAction(
          icon: Icons.notifications_none_rounded,
          title: 'Notification preferences',
          subtitle: 'Manage email and request updates',
        ),
        const _ProfileAction(
          icon: Icons.support_agent_rounded,
          title: 'Contact Zoko support',
          subtitle: 'Get help from the marketplace team',
        ),
        _ProfileAction(
          icon: Icons.logout_rounded,
          title: 'Log out',
          subtitle: 'Return to authentication',
          color: const Color(0xFFB42318),
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute<void>(
                builder: (_) => const AuthWelcomeScreen(),
              ),
              (route) => false,
            );
          },
        ),
      ],
    );
  }
}

class _ProfileSection extends StatelessWidget {
  const _ProfileSection({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: ZokoColors.navy,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 12),
          for (final child in children) ...[
            child,
            if (child != children.last)
              const Divider(height: 20, color: ZokoColors.softGrey),
          ],
        ],
      ),
    );
  }
}

class _ProfileAction extends StatelessWidget {
  const _ProfileAction({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.color = ZokoColors.teal,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: ZokoColors.navy,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: ZokoColors.textGrey,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: color),
        ],
      ),
    );
  }
}

BoxDecoration _cardDecoration() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: ZokoColors.softGrey),
    boxShadow: [
      BoxShadow(
        color: ZokoColors.navy.withValues(alpha: 0.08),
        blurRadius: 14,
        offset: const Offset(0, 7),
      ),
    ],
  );
}
