import 'package:flutter/material.dart';
import 'package:zoko_marketplace/core/layout/responsive_breakpoints.dart';
import 'package:zoko_marketplace/core/theme/zoko_colors.dart';
import 'package:zoko_marketplace/models/hire_request_model.dart';
import 'package:zoko_marketplace/utils/hire_request_status_ui.dart';
import 'package:zoko_marketplace/widgets/shared/responsive_page.dart';

class HireRequestDetailsScreen extends StatelessWidget {
  const HireRequestDetailsScreen({super.key, required this.request});

  static const routeName = '/hire-request-details';

  final HireRequestModel request;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Request details'),
      ),
      body: SafeArea(
        child: ResponsivePage(
          maxWidth: 1180,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = ResponsiveBreakpoints.isDesktop(
                constraints.maxWidth,
              );

              final details = Column(
                children: [
                  _RequestHero(request: request),
                  const SizedBox(height: 18),
                  _DescriptionPanel(request: request),
                  const SizedBox(height: 18),
                  const _ReferencePicturesPanel(),
                ],
              );

              final process = Column(
                children: [
                  _TimelinePanel(request: request),
                  const SizedBox(height: 18),
                  _ActionsPanel(request: request),
                ],
              );

              return ListView(
                children: [
                  if (isDesktop)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 7, child: details),
                        const SizedBox(width: 24),
                        SizedBox(width: 360, child: process),
                      ],
                    )
                  else ...[
                    details,
                    const SizedBox(height: 18),
                    process,
                  ],
                ],
              );
            },
          ),
        ),
      ),
      backgroundColor: ZokoColors.canvas,
    );
  }
}

class _RequestHero extends StatelessWidget {
  const _RequestHero({required this.request});

  final HireRequestModel request;

  @override
  Widget build(BuildContext context) {
    final statusColor = hireRequestStatusColor(request.status);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ZokoColors.navy,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipOval(
                child: Image.asset(
                  request.professional.imageAsset,
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request.professional.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      request.professional.role,
                      style: const TextStyle(
                        color: Color(0xFFC9D5DD),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  hireRequestStatusLabel(request.status),
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            request.projectTitle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              height: 1.08,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _HeroMeta(icon: Icons.payments_rounded, label: request.budget),
              _HeroMeta(
                icon: Icons.event_available_rounded,
                label: request.deadline,
              ),
              _HeroMeta(
                icon: Icons.schedule_rounded,
                label: _formatSubmittedDate(request.createdAt),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroMeta extends StatelessWidget {
  const _HeroMeta({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: ZokoColors.green, size: 17),
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

class _DescriptionPanel extends StatelessWidget {
  const _DescriptionPanel({required this.request});

  final HireRequestModel request;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Project description',
            style: TextStyle(
              color: ZokoColors.navy,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            request.description,
            style: const TextStyle(color: ZokoColors.textGrey, height: 1.45),
          ),
        ],
      ),
    );
  }
}

class _ReferencePicturesPanel extends StatelessWidget {
  const _ReferencePicturesPanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: const Row(
        children: [
          Icon(Icons.image_outlined, color: ZokoColors.teal),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reference pictures',
                  style: TextStyle(
                    color: ZokoColors.navy,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'No pictures attached yet.',
                  style: TextStyle(color: ZokoColors.textGrey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelinePanel extends StatelessWidget {
  const _TimelinePanel({required this.request});

  final HireRequestModel request;

  @override
  Widget build(BuildContext context) {
    final steps = [
      _TimelineStepData(
        label: 'Request submitted',
        isActive: true,
        icon: Icons.check_circle_rounded,
      ),
      _TimelineStepData(
        label: 'Admin reviewing',
        isActive: _isAtLeast(
          request.status,
          HireRequestStatus.pendingAdminReview,
        ),
        icon: Icons.manage_search_rounded,
      ),
      _TimelineStepData(
        label: 'Professional contacted',
        isActive: _isAtLeast(
          request.status,
          HireRequestStatus.contactingProfessional,
        ),
        icon: Icons.handshake_rounded,
      ),
      _TimelineStepData(
        label: 'Quote received',
        isActive: _isAtLeast(request.status, HireRequestStatus.quoteReceived),
        icon: Icons.request_quote_rounded,
      ),
      _TimelineStepData(
        label: 'Invoice sent',
        isActive: _isAtLeast(request.status, HireRequestStatus.invoiceSent),
        icon: Icons.receipt_long_rounded,
      ),
      _TimelineStepData(
        label: 'Work started',
        isActive: _isAtLeast(request.status, HireRequestStatus.inProgress),
        icon: Icons.build_circle_rounded,
      ),
      _TimelineStepData(
        label: 'Completed',
        isActive: _isAtLeast(request.status, HireRequestStatus.completed),
        icon: Icons.verified_rounded,
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Request timeline',
            style: TextStyle(
              color: ZokoColors.navy,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 14),
          for (final step in steps) _TimelineStep(step: step),
        ],
      ),
    );
  }
}

class _TimelineStep extends StatelessWidget {
  const _TimelineStep({required this.step});

  final _TimelineStepData step;

  @override
  Widget build(BuildContext context) {
    final color = step.isActive ? ZokoColors.teal : ZokoColors.textGrey;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: color.withValues(alpha: step.isActive ? 0.12 : 0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(step.icon, color: color, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              step.label,
              style: TextStyle(
                color: step.isActive ? ZokoColors.navy : ZokoColors.textGrey,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineStepData {
  const _TimelineStepData({
    required this.label,
    required this.isActive,
    required this.icon,
  });

  final String label;
  final bool isActive;
  final IconData icon;
}

class _ActionsPanel extends StatelessWidget {
  const _ActionsPanel({required this.request});

  final HireRequestModel request;

  @override
  Widget build(BuildContext context) {
    final canViewInvoice =
        request.status == HireRequestStatus.invoiceSent ||
        request.status == HireRequestStatus.paid ||
        request.status == HireRequestStatus.inProgress ||
        request.status == HireRequestStatus.completed;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FilledButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.support_agent_rounded),
            label: const Text('Contact Zoko admin'),
          ),
          const SizedBox(height: 10),
          if (canViewInvoice) ...[
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.receipt_long_rounded),
              label: const Text('View invoice'),
            ),
            const SizedBox(height: 10),
          ],
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.cancel_outlined),
            label: const Text('Cancel request'),
          ),
        ],
      ),
    );
  }
}

bool _isAtLeast(HireRequestStatus current, HireRequestStatus target) {
  const rank = {
    HireRequestStatus.pendingAdminReview: 0,
    HireRequestStatus.contactingProfessional: 1,
    HireRequestStatus.quoteReceived: 2,
    HireRequestStatus.invoiceSent: 3,
    HireRequestStatus.paid: 4,
    HireRequestStatus.inProgress: 5,
    HireRequestStatus.completed: 6,
  };

  if (current == HireRequestStatus.cancelled) {
    return false;
  }

  return rank[current]! >= rank[target]!;
}

String _formatSubmittedDate(DateTime date) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  return '${months[date.month - 1]} ${date.day}, ${date.year}';
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
