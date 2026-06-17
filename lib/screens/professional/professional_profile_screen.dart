import 'package:flutter/material.dart';
import 'package:zoko_marketplace/core/constants/app_assets.dart';
import 'package:zoko_marketplace/core/theme/zoko_colors.dart';
import 'package:zoko_marketplace/core/theme/zoko_theme.dart';
import 'package:zoko_marketplace/screens/auth/auth_welcome_screen.dart';
import 'package:zoko_marketplace/widgets/app/professional_bottom_nav.dart';
import 'package:zoko_marketplace/widgets/shared/appearance_selector.dart';
import 'package:zoko_marketplace/widgets/shared/responsive_page.dart';

class ProfessionalProfileScreen extends StatelessWidget {
  const ProfessionalProfileScreen({super.key});

  static const routeName = '/professional-account';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: ResponsivePage(
          maxWidth: 1100,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 820;
              final profileSummary = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _ProfileHero(),
                  SizedBox(height: 18),
                  _AvailabilityCard(),
                  SizedBox(height: 18),
                  _AccountSettingsCard(),
                ],
              );

              final profileDetails = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _AboutCard(),
                  SizedBox(height: 18),
                  _SkillsCard(),
                  SizedBox(height: 18),
                  _PortfolioCard(),
                ],
              );

              return ListView(
                padding: const EdgeInsets.only(bottom: 92),
                children: [
                  if (isWide)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 5, child: profileSummary),
                        const SizedBox(width: 28),
                        Expanded(flex: 7, child: profileDetails),
                      ],
                    )
                  else ...[
                    profileSummary,
                    const SizedBox(height: 18),
                    profileDetails,
                  ],
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: const ProfessionalBottomNav(selectedIndex: 3),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }
}

class _ProfileHero extends StatelessWidget {
  const _ProfileHero();

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: Image.asset(
                  AppAssets.samuelProfile,
                  width: 74,
                  height: 74,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Samuel O.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Full Stack Developer',
                      style: TextStyle(
                        color: Color(0xFFC9D5DD),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.edit_rounded, color: ZokoColors.green),
            ],
          ),
          const SizedBox(height: 18),
          const Text(
            'Builds responsive websites, dashboards, and full-stack business tools for local businesses.',
            style: TextStyle(
              color: Color(0xFFC9D5DD),
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: const [
              _HeroPill(icon: Icons.location_on_rounded, label: 'Tema, Ghana'),
              _HeroPill(icon: Icons.star_rounded, label: '4.9 rating'),
              _HeroPill(icon: Icons.payments_rounded, label: 'From GHS 900'),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroPill extends StatelessWidget {
  const _HeroPill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: ZokoColors.green, size: 16),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _AvailabilityCard extends StatelessWidget {
  const _AvailabilityCard();

  @override
  Widget build(BuildContext context) {
    final themeColors = ZokoThemeColors.of(context);

    return _Panel(
      title: 'Availability',
      action: 'Edit',
      children: [
        const _StatusRow(
          icon: Icons.check_circle_rounded,
          title: 'Available for new work',
          subtitle: 'Usually replies within 2 hours',
          color: ZokoColors.green,
        ),
        Divider(height: 22, color: themeColors.border),
        const _StatusRow(
          icon: Icons.schedule_rounded,
          title: 'Preferred timeline',
          subtitle: 'Short projects, 1-3 weeks',
          color: ZokoColors.teal,
        ),
      ],
    );
  }
}

class _AboutCard extends StatelessWidget {
  const _AboutCard();

  @override
  Widget build(BuildContext context) {
    final themeColors = ZokoThemeColors.of(context);

    return _Panel(
      title: 'Professional details',
      action: 'Edit',
      children: [
        Text(
          'I help businesses launch websites, internal dashboards, booking tools, and marketplace workflows. I focus on clean UI, reliable APIs, and practical delivery timelines.',
          style: TextStyle(
            color: themeColors.mutedText,
            fontWeight: FontWeight.w600,
            height: 1.45,
          ),
        ),
      ],
    );
  }
}

class _SkillsCard extends StatelessWidget {
  const _SkillsCard();

  @override
  Widget build(BuildContext context) {
    return _Panel(
      title: 'Skills and pricing',
      action: 'Edit',
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: const [
            _SkillChip(label: 'Flutter'),
            _SkillChip(label: 'Web apps'),
            _SkillChip(label: 'APIs'),
            _SkillChip(label: 'Dashboards'),
            _SkillChip(label: 'UI implementation'),
          ],
        ),
        const SizedBox(height: 16),
        const _StatusRow(
          icon: Icons.payments_rounded,
          title: 'Starting price',
          subtitle: 'From GHS 900',
          color: ZokoColors.green,
        ),
      ],
    );
  }
}

class _PortfolioCard extends StatelessWidget {
  const _PortfolioCard();

  @override
  Widget build(BuildContext context) {
    final samples = const [
      _PortfolioSample(
        title: 'Admin dashboard',
        subtitle: 'Analytics and order management',
        icon: Icons.dashboard_customize_rounded,
        color: ZokoColors.teal,
      ),
      _PortfolioSample(
        title: 'Marketplace app',
        subtitle: 'Client and vendor workflow',
        icon: Icons.storefront_rounded,
        color: ZokoColors.green,
      ),
      _PortfolioSample(
        title: 'API integration',
        subtitle: 'Payments and notifications',
        icon: Icons.api_rounded,
        color: ZokoColors.cyan,
      ),
    ];

    return _Panel(
      title: 'Portfolio samples',
      action: 'Add',
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 620;

            return GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: isWide ? 3 : 1,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: isWide ? 1.7 : 4.15,
              children: samples,
            );
          },
        ),
      ],
    );
  }
}

class _AccountSettingsCard extends StatelessWidget {
  const _AccountSettingsCard();

  @override
  Widget build(BuildContext context) {
    final themeColors = ZokoThemeColors.of(context);

    return _Panel(
      title: 'Account',
      action: 'Manage',
      children: [
        const _StatusRow(
          icon: Icons.notifications_none_rounded,
          title: 'Notifications',
          subtitle: 'Manage job and proposal updates',
          color: ZokoColors.teal,
        ),
        Divider(height: 22, color: themeColors.border),
        const AppearanceSelector(),
        Divider(height: 22, color: themeColors.border),
        _ProfileAction(
          icon: Icons.logout_rounded,
          title: 'Sign out',
          subtitle: 'Return to the welcome screen',
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

class _Panel extends StatelessWidget {
  const _Panel({
    required this.title,
    required this.action,
    required this.children,
  });

  final String title;
  final String action;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final themeColors = ZokoThemeColors.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: themeColors.text,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Text(
                action,
                style: const TextStyle(
                  color: ZokoColors.teal,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...children,
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
    final themeColors = ZokoThemeColors.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 21),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: themeColors.text,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: themeColors.mutedText,
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

class _StatusRow extends StatelessWidget {
  const _StatusRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final themeColors = ZokoThemeColors.of(context);

    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 21),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: themeColors.text,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: TextStyle(
                  color: themeColors.mutedText,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SkillChip extends StatelessWidget {
  const _SkillChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final themeColors = ZokoThemeColors.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: ZokoColors.teal.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: themeColors.text,
          fontSize: 12,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class _PortfolioSample extends StatelessWidget {
  const _PortfolioSample({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final themeColors = ZokoThemeColors.of(context);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: themeColors.canvas,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: themeColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 22),
          const Spacer(),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: themeColors.text,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: themeColors.mutedText,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

BoxDecoration _cardDecoration(BuildContext context) {
  final themeColors = ZokoThemeColors.of(context);

  return BoxDecoration(
    color: themeColors.card,
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: themeColors.border),
    boxShadow: [
      BoxShadow(
        color: themeColors.shadow,
        blurRadius: 14,
        offset: const Offset(0, 7),
      ),
    ],
  );
}
