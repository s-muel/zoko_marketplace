import 'package:flutter/material.dart';
import 'package:zoko_marketplace/core/theme/zoko_colors.dart';
import 'package:zoko_marketplace/core/theme/zoko_theme.dart';
import 'package:zoko_marketplace/models/job_post_model.dart';

class HotJobs extends StatelessWidget {
  const HotJobs({super.key, required this.jobs});

  final List<JobPostModel> jobs;

  @override
  Widget build(BuildContext context) {
    final previewJobs = jobs.take(4).toList();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: previewJobs.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        mainAxisExtent: 204,
      ),
      itemBuilder: (context, index) {
        return HotJobCard(job: previewJobs[index], width: null);
      },
    );
  }
}

class HotJobsHeader extends StatelessWidget {
  const HotJobsHeader({
    super.key,
    required this.onPostJob,
    required this.onViewAll,
  });

  final VoidCallback onPostJob;
  final VoidCallback onViewAll;

  @override
  Widget build(BuildContext context) {
    final themeColors = ZokoThemeColors.of(context);

    return Row(
      children: [
        Expanded(
          child: Text(
            'Hot Jobs',
            style: TextStyle(
              color: themeColors.text,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        TextButton.icon(
          onPressed: onPostJob,
          icon: const Icon(Icons.add_rounded, size: 18),
          label: const Text('Post job'),
          style: TextButton.styleFrom(
            foregroundColor: themeColors.text,
            textStyle: const TextStyle(fontWeight: FontWeight.w900),
          ),
        ),
        const SizedBox(width: 6),
        InkWell(
          onTap: onViewAll,
          borderRadius: BorderRadius.circular(8),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            child: Text(
              'View all',
              style: TextStyle(
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

class HotJobCard extends StatelessWidget {
  const HotJobCard({
    super.key,
    required this.job,
    this.width = 252,
    this.onTap,
  });

  final JobPostModel job;
  final double? width;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final themeColors = ZokoThemeColors.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: width,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: themeColors.card,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: themeColors.border),
            boxShadow: [
              BoxShadow(
                color: themeColors.shadow,
                blurRadius: 18,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: job.color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(job.icon, color: job.color, size: 22),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          job.category,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: themeColors.text,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          job.postedAt,
                          style: TextStyle(
                            color: themeColors.mutedText,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                job.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: themeColors.text,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                job.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: themeColors.mutedText,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      job.budget,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: ZokoColors.green,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.schedule_rounded,
                  color: ZokoColors.navy.withValues(alpha: 0.68),
                  size: 16,
                ),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      job.deadline,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: themeColors.text,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
