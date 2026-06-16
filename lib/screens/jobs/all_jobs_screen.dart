import 'package:flutter/material.dart';
import 'package:zoko_marketplace/core/layout/responsive_breakpoints.dart';
import 'package:zoko_marketplace/core/theme/zoko_colors.dart';
import 'package:zoko_marketplace/screens/jobs/post_job_screen.dart';
import 'package:zoko_marketplace/services/marketplace_service.dart';
import 'package:zoko_marketplace/widgets/home/hot_jobs.dart';
import 'package:zoko_marketplace/widgets/shared/responsive_page.dart';

class AllJobsScreen extends StatelessWidget {
  const AllJobsScreen({super.key});

  static const routeName = '/jobs';
  static const _marketplaceService = MarketplaceService();

  @override
  Widget build(BuildContext context) {
    final jobs = _marketplaceService.getHotJobs();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hot Jobs'),
        backgroundColor: ZokoColors.canvas,
        foregroundColor: ZokoColors.navy,
        elevation: 0,
      ),
      body: SafeArea(
        child: ResponsivePage(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = ResponsiveBreakpoints.isDesktop(
                constraints.maxWidth,
              );

              return ListView(
                padding: const EdgeInsets.only(bottom: 92),
                children: [
                  _JobsHeader(totalCount: jobs.length),
                  const SizedBox(height: 18),
                  if (isDesktop)
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: jobs.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        mainAxisExtent: 188,
                      ),
                      itemBuilder: (context, index) {
                        return HotJobCard(job: jobs[index], width: null);
                      },
                    )
                  else
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: jobs.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 14),
                      itemBuilder: (context, index) {
                        return HotJobCard(job: jobs[index], width: null);
                      },
                    ),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushNamed(PostJobScreen.routeName);
        },
        icon: const Icon(Icons.add_rounded),
        label: const Text('Post job'),
      ),
      backgroundColor: ZokoColors.canvas,
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
      child: LayoutBuilder(
        builder: (context, constraints) {
          final headerText = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Browse client job posts',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '$totalCount open jobs available now',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.78),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          );

          final postButton = FilledButton.icon(
            onPressed: () {
              Navigator.of(context).pushNamed(PostJobScreen.routeName);
            },
            icon: const Icon(Icons.add_rounded),
            label: const Text('Post job'),
          );

          if (constraints.maxWidth < 520) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                headerText,
                const SizedBox(height: 16),
                postButton,
              ],
            );
          }

          return Row(
            children: [
              Expanded(child: headerText),
              const SizedBox(width: 12),
              postButton,
            ],
          );
        },
      ),
    );
  }
}
