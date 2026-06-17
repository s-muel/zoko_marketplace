import 'package:flutter/material.dart';
import 'package:zoko_marketplace/core/theme/zoko_colors.dart';
import 'package:zoko_marketplace/screens/jobs/job_details_screen.dart';
import 'package:zoko_marketplace/screens/professional/professional_dashboard_screen.dart';
import 'package:zoko_marketplace/services/marketplace_service.dart';
import 'package:zoko_marketplace/widgets/app/professional_bottom_nav.dart';
import 'package:zoko_marketplace/widgets/home/hot_jobs.dart';
import 'package:zoko_marketplace/widgets/shared/responsive_page.dart';

class ProfessionalJobsScreen extends StatelessWidget {
  const ProfessionalJobsScreen({super.key});

  static const routeName = '/professional-jobs';
  static const _marketplaceService = MarketplaceService();

  @override
  Widget build(BuildContext context) {
    final jobs = _marketplaceService.getHotJobs();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          tooltip: 'Back to dashboard',
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
              return;
            }

            Navigator.of(context).pushNamedAndRemoveUntil(
              ProfessionalDashboardScreen.routeName,
              (route) => false,
            );
          },
        ),
        title: const Text('Available jobs'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        elevation: 0,
      ),
      body: SafeArea(
        child: ResponsivePage(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 720;

              return ListView(
                padding: const EdgeInsets.only(bottom: 32),
                children: [
                  _JobsHeader(totalCount: jobs.length),
                  const SizedBox(height: 18),
                  if (isWide)
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: jobs.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
                    )
                  else
                    ListView.separated(
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
                    ),
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: const ProfessionalBottomNav(selectedIndex: 1),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }
}

class _JobsHeader extends StatelessWidget {
  const _JobsHeader({required this.totalCount});

  final int totalCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: ZokoColors.navy,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Find jobs you can handle',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$totalCount jobs available for professionals',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.78),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
