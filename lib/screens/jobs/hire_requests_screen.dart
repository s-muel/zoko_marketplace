import 'package:flutter/material.dart';
import 'package:zoko_marketplace/core/layout/responsive_breakpoints.dart';
import 'package:zoko_marketplace/core/theme/zoko_colors.dart';
import 'package:zoko_marketplace/core/theme/zoko_theme.dart';
import 'package:zoko_marketplace/models/hire_request_model.dart';
import 'package:zoko_marketplace/services/request_tracking_service.dart';
import 'package:zoko_marketplace/screens/jobs/hire_request_details_screen.dart';
import 'package:zoko_marketplace/utils/hire_request_status_ui.dart';
import 'package:zoko_marketplace/widgets/app/zoko_bottom_nav.dart';
import 'package:zoko_marketplace/widgets/shared/responsive_page.dart';

class HireRequestsScreen extends StatefulWidget {
  const HireRequestsScreen({super.key});

  static const routeName = '/hire-requests';

  @override
  State<HireRequestsScreen> createState() => _HireRequestsScreenState();
}

class _HireRequestsScreenState extends State<HireRequestsScreen> {
  static const _requestService = RequestTrackingService();

  HireRequestStatus? _selectedStatus;

  @override
  Widget build(BuildContext context) {
    final requests = _filteredRequests(_requestService.getClientRequests());

    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: ResponsivePage(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = ResponsiveBreakpoints.isDesktop(
                constraints.maxWidth,
              );

              return ListView(
                children: [
                  _RequestsHeader(totalCount: requests.length),
                  const SizedBox(height: 18),
                  _StatusFilters(
                    selectedStatus: _selectedStatus,
                    onSelected: (status) {
                      setState(() => _selectedStatus = status);
                    },
                  ),
                  const SizedBox(height: 18),
                  if (requests.isEmpty)
                    const _EmptyRequests()
                  else
                    _RequestsGrid(
                      requests: requests,
                      isDesktop: isDesktop,
                    ),
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: const ZokoBottomNav(selectedIndex: 2),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }

  List<HireRequestModel> _filteredRequests(List<HireRequestModel> requests) {
    if (_selectedStatus == null) {
      return requests;
    }

    return requests
        .where((request) => request.status == _selectedStatus)
        .toList();
  }
}

class _RequestsHeader extends StatelessWidget {
  const _RequestsHeader({required this.totalCount});

  final int totalCount;

  @override
  Widget build(BuildContext context) {
    final themeColors = ZokoThemeColors.of(context);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(context),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: ZokoColors.teal.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.assignment_rounded,
              color: ZokoColors.teal,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hire requests',
                  style: TextStyle(
                    color: themeColors.text,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$totalCount active request${totalCount == 1 ? '' : 's'}',
                  style: TextStyle(
                    color: themeColors.mutedText,
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

class _StatusFilters extends StatelessWidget {
  const _StatusFilters({
    required this.selectedStatus,
    required this.onSelected,
  });

  final HireRequestStatus? selectedStatus;
  final ValueChanged<HireRequestStatus?> onSelected;

  @override
  Widget build(BuildContext context) {
    final themeColors = ZokoThemeColors.of(context);
    final statuses = [
      null,
      HireRequestStatus.pendingAdminReview,
      HireRequestStatus.quoteReceived,
      HireRequestStatus.invoiceSent,
      HireRequestStatus.inProgress,
      HireRequestStatus.completed,
    ];

    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: statuses.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final status = statuses[index];
          final isSelected = status == selectedStatus;

          return ChoiceChip(
            selected: isSelected,
            showCheckmark: false,
            selectedColor: ZokoColors.teal,
            backgroundColor: themeColors.card,
            side: BorderSide(
              color: isSelected ? ZokoColors.teal : themeColors.border,
            ),
            label: Text(
              status == null ? 'All' : hireRequestStatusLabel(status),
            ),
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : themeColors.text,
              fontWeight: FontWeight.w900,
            ),
            onSelected: (_) => onSelected(status),
          );
        },
      ),
    );
  }
}

class _RequestsGrid extends StatelessWidget {
  const _RequestsGrid({required this.requests, required this.isDesktop});

  final List<HireRequestModel> requests;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: requests.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isDesktop ? 2 : 1,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: isDesktop ? 1.85 : 1.45,
      ),
      itemBuilder: (context, index) {
        return _RequestCard(request: requests[index]);
      },
    );
  }
}

class _RequestCard extends StatelessWidget {
  const _RequestCard({required this.request});

  final HireRequestModel request;

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
              ClipOval(
                child: Image.asset(
                  request.professional.imageAsset,
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request.professional.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: themeColors.text,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      request.professional.role,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: themeColors.mutedText,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              _StatusPill(status: request.status),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            request.projectTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: themeColors.text,
              fontSize: 17,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            request.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: themeColors.mutedText, height: 1.35),
          ),
          const Spacer(),
          Row(
            children: [
              _RequestMeta(icon: Icons.payments_rounded, label: request.budget),
              const SizedBox(width: 10),
              Expanded(
                child: _RequestMeta(
                  icon: Icons.event_available_rounded,
                  label: request.deadline,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.of(context).pushNamed(
                HireRequestDetailsScreen.routeName,
                arguments: request,
              );
            },
            icon: const Icon(Icons.visibility_rounded),
            label: const Text('View details'),
          ),
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.status});

  final HireRequestStatus status;

  @override
  Widget build(BuildContext context) {
    final color = hireRequestStatusColor(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.11),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        hireRequestStatusLabel(status),
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class _RequestMeta extends StatelessWidget {
  const _RequestMeta({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final themeColors = ZokoThemeColors.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: ZokoColors.teal, size: 17),
        const SizedBox(width: 5),
        Flexible(
          child: Text(
            label,
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
    );
  }
}

class _EmptyRequests extends StatelessWidget {
  const _EmptyRequests();

  @override
  Widget build(BuildContext context) {
    final themeColors = ZokoThemeColors.of(context);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: _cardDecoration(context),
      child: Column(
        children: [
          const Icon(
            Icons.assignment_late_rounded,
            color: ZokoColors.teal,
            size: 44,
          ),
          const SizedBox(height: 10),
          Text(
            'No requests here',
            style: TextStyle(
              color: themeColors.text,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Try another status or request a hire from a professional profile.',
            textAlign: TextAlign.center,
            style: TextStyle(color: themeColors.mutedText, height: 1.4),
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
