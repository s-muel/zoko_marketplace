import 'package:flutter/material.dart';
import 'package:zoko_marketplace/core/layout/responsive_breakpoints.dart';
import 'package:zoko_marketplace/core/theme/zoko_colors.dart';
import 'package:zoko_marketplace/models/job_post_model.dart';
import 'package:zoko_marketplace/screens/jobs/job_details_screen.dart';
import 'package:zoko_marketplace/screens/professional/professional_jobs_screen.dart';
import 'package:zoko_marketplace/services/marketplace_service.dart';
import 'package:zoko_marketplace/widgets/app/professional_bottom_nav.dart';
import 'package:zoko_marketplace/widgets/home/hot_jobs.dart';
import 'package:zoko_marketplace/widgets/shared/responsive_page.dart';

class ProfessionalDashboardScreen extends StatelessWidget {
  const ProfessionalDashboardScreen({super.key});

  static const routeName = '/professional-dashboard';
  static const _marketplaceService = MarketplaceService();

  @override
  Widget build(BuildContext context) {
    final jobs = _marketplaceService.getHotJobs();

    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: ResponsivePage(
          maxWidth: 1100,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = ResponsiveBreakpoints.isDesktop(
                constraints.maxWidth,
              );

              final dashboardContent = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _ProfessionalHeader(),
                  const SizedBox(height: 18),
                  const _ProfessionalStats(),
                ],
              );

              final toolsPanel = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _ProfessionalActions(),
                ],
              );

              return ListView(
                padding: const EdgeInsets.only(bottom: 92),
                children: [
                  if (isDesktop)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 7, child: dashboardContent),
                        const SizedBox(width: 28),
                        Expanded(flex: 5, child: toolsPanel),
                      ],
                    )
                  else ...[
                    dashboardContent,
                    const SizedBox(height: 18),
                    toolsPanel,
                  ],
                  const SizedBox(height: 24),
                  _SectionHeader(
                    title: 'Recommended jobs',
                    action: 'View all',
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        ProfessionalJobsScreen.routeName,
                      );
                    },
                  ),
                  const SizedBox(height: 14),
                  _RecommendedJobsList(jobs: jobs),
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: const ProfessionalBottomNav(selectedIndex: 0),
      backgroundColor: ZokoColors.canvas,
    );
  }
}

class _RecommendedJobsList extends StatelessWidget {
  const _RecommendedJobsList({required this.jobs});

  final List<JobPostModel> jobs;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 720;

        if (isWide) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: jobs.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              mainAxisExtent: 204,
            ),
            itemBuilder: (context, index) {
              return HotJobCard(
                job: jobs[index],
                width: null,
                onTap: () {
                  Navigator.of(context).pushNamed(
                    JobDetailsScreen.routeName,
                    arguments: jobs[index],
                  );
                },
              );
            },
          );
        }

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: jobs.length,
          separatorBuilder: (_, _) => const SizedBox(height: 14),
          itemBuilder: (context, index) {
            return SizedBox(
              height: 204,
              child: HotJobCard(
                job: jobs[index],
                width: null,
                onTap: () {
                  Navigator.of(context).pushNamed(
                    JobDetailsScreen.routeName,
                    arguments: jobs[index],
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}

class _ProfessionalHeader extends StatelessWidget {
  const _ProfessionalHeader();

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
      child: LayoutBuilder(
        builder: (context, constraints) {
          final profile = Row(
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: ZokoColors.green.withValues(alpha: 0.16),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'PK',
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
                      'Professional dashboard',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Manage jobs, proposals, portfolio, and profile visibility.',
                      style: TextStyle(
                        color: Color(0xFFC9D5DD),
                        fontWeight: FontWeight.w700,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );

          final status = Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: ZokoColors.green.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Profile 82% complete',
              style: TextStyle(
                color: ZokoColors.green,
                fontWeight: FontWeight.w900,
              ),
            ),
          );

          if (constraints.maxWidth < 680) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                profile,
                const SizedBox(height: 16),
                status,
              ],
            );
          }

          return Row(
            children: [
              Expanded(child: profile),
              const SizedBox(width: 18),
              status,
            ],
          );
        },
      ),
    );
  }
}

class _ProfessionalStats extends StatelessWidget {
  const _ProfessionalStats();

  @override
  Widget build(BuildContext context) {
    final stats = const [
      _StatCard(
        label: 'Job matches',
        value: '12',
        icon: Icons.work_rounded,
        color: ZokoColors.teal,
      ),
      _StatCard(
        label: 'Proposals',
        value: '5',
        icon: Icons.send_rounded,
        color: ZokoColors.cyan,
      ),
      _StatCard(
        label: 'Active jobs',
        value: '2',
        icon: Icons.timelapse_rounded,
        color: ZokoColors.green,
      ),
      _StatCard(
        label: 'Rating',
        value: '4.9',
        icon: Icons.star_rounded,
        color: Color(0xFFF5A623),
      ),
    ];

    return SizedBox(
      height: 92,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: stats.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) => stats[index],
      ),
    );
  }
}

class _ProfessionalActions extends StatelessWidget {
  const _ProfessionalActions();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Professional tools',
            style: TextStyle(
              color: ZokoColors.navy,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 12),
          _ActionTile(
            icon: Icons.badge_rounded,
            title: 'Edit professional profile',
            subtitle: 'Update your title, skills, pricing, and availability',
          ),
          Divider(height: 20, color: ZokoColors.softGrey),
          _ActionTile(
            icon: Icons.photo_library_rounded,
            title: 'Manage portfolio',
            subtitle: 'Add work samples clients can view before hiring',
          ),
          Divider(height: 20, color: ZokoColors.softGrey),
          _ActionTile(
            icon: Icons.receipt_long_rounded,
            title: 'Proposals and invoices',
            subtitle: 'Track interested jobs, quotes, and payments',
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.action,
    required this.onTap,
  });

  final String title;
  final String action;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: ZokoColors.navy,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            child: Text(
              action,
              style: const TextStyle(
                color: ZokoColors.teal,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 112,
      padding: const EdgeInsets.all(14),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: color, size: 22),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: ZokoColors.navy,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: ZokoColors.green,
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: ZokoColors.teal.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: ZokoColors.teal),
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
        const Icon(Icons.chevron_right_rounded, color: ZokoColors.teal),
      ],
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
