import 'package:flutter/material.dart';
import 'package:zoko_marketplace/core/theme/zoko_colors.dart';
import 'package:zoko_marketplace/models/job_post_model.dart';
import 'package:zoko_marketplace/widgets/shared/responsive_page.dart';

class JobDetailsScreen extends StatelessWidget {
  const JobDetailsScreen({super.key, required this.job});

  static const routeName = '/job-details';

  final JobPostModel job;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job details'),
        backgroundColor: ZokoColors.canvas,
        foregroundColor: ZokoColors.navy,
        elevation: 0,
      ),
      body: SafeArea(
        child: ResponsivePage(
          maxWidth: 920,
          child: ListView(
            children: [
              _JobHero(job: job),
              const SizedBox(height: 18),
              _JobInfoGrid(job: job),
              const SizedBox(height: 18),
              _DetailsPanel(job: job),
              const SizedBox(height: 18),
              const _InterestPanel(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
      backgroundColor: ZokoColors.canvas,
    );
  }
}

class _JobHero extends StatelessWidget {
  const _JobHero({required this.job});

  final JobPostModel job;

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: job.color.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(job.icon, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  job.category,
                  style: const TextStyle(
                    color: ZokoColors.green,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  job.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    height: 1.14,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Posted by ${job.clientName}',
                  style: const TextStyle(
                    color: Color(0xFFC9D5DD),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _JobInfoGrid extends StatelessWidget {
  const _JobInfoGrid({required this.job});

  final JobPostModel job;

  @override
  Widget build(BuildContext context) {
    final items = [
      _InfoItem(icon: Icons.payments_rounded, label: 'Budget', value: job.budget),
      _InfoItem(icon: Icons.schedule_rounded, label: 'Deadline', value: job.deadline),
      _InfoItem(icon: Icons.category_rounded, label: 'Category', value: job.category),
      _InfoItem(icon: Icons.today_rounded, label: 'Posted', value: job.postedAt),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth > 680 ? 4 : 2;

        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: columns,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: columns == 4 ? 1.45 : 1.75,
          children: items,
        );
      },
    );
  }
}

class _InfoItem extends StatelessWidget {
  const _InfoItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

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
            label,
            style: const TextStyle(
              color: ZokoColors.textGrey,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: ZokoColors.navy,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailsPanel extends StatelessWidget {
  const _DetailsPanel({required this.job});

  final JobPostModel job;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'What the client needs',
            style: TextStyle(
              color: ZokoColors.navy,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            job.description,
            style: const TextStyle(
              color: ZokoColors.textGrey,
              fontSize: 15,
              height: 1.45,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _InterestPanel extends StatefulWidget {
  const _InterestPanel();

  @override
  State<_InterestPanel> createState() => _InterestPanelState();
}

class _InterestPanelState extends State<_InterestPanel> {
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Show interest',
            style: TextStyle(
              color: ZokoColors.navy,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Send a short note so admin can match you with the client.',
            style: TextStyle(
              color: ZokoColors.textGrey,
              fontWeight: FontWeight.w600,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _messageController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Example: I can handle this job within the timeline.',
              filled: true,
              fillColor: ZokoColors.canvas,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: ZokoColors.softGrey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: ZokoColors.softGrey),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Interest sent for admin review.'),
                  ),
                );
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.send_rounded),
              label: const Text('I am interested'),
            ),
          ),
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
