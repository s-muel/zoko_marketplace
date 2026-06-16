import 'package:flutter/material.dart';
import 'package:zoko_marketplace/core/layout/responsive_breakpoints.dart';
import 'package:zoko_marketplace/core/theme/zoko_colors.dart';
import 'package:zoko_marketplace/models/hire_request_model.dart';
import 'package:zoko_marketplace/services/request_tracking_service.dart';
import 'package:zoko_marketplace/utils/hire_request_status_ui.dart';
import 'package:zoko_marketplace/widgets/shared/responsive_page.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  static const routeName = '/admin';

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  static const _requestService = RequestTrackingService();

  late final List<HireRequestModel> _requests;
  late HireRequestModel _selectedRequest;
  HireRequestStatus _selectedStatus = HireRequestStatus.pendingAdminReview;

  @override
  void initState() {
    super.initState();
    _requests = _requestService.getClientRequests();
    _selectedRequest = _requests.first;
    _selectedStatus = _selectedRequest.status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Admin dashboard'),
      ),
      body: SafeArea(
        child: ResponsivePage(
          maxWidth: 1220,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = ResponsiveBreakpoints.isDesktop(
                constraints.maxWidth,
              );

              final queue = Column(
                children: [
                  _AdminHeader(requests: _requests),
                  const SizedBox(height: 18),
                  _RequestQueue(
                    requests: _requests,
                    selectedRequest: _selectedRequest,
                    onSelected: (request) {
                      setState(() {
                        _selectedRequest = request;
                        _selectedStatus = request.status;
                      });
                    },
                  ),
                ],
              );

              final detail = _AdminRequestDetail(
                request: _selectedRequest,
                selectedStatus: _selectedStatus,
                onStatusChanged: (status) {
                  setState(() => _selectedStatus = status);
                },
              );

              return ListView(
                children: [
                  if (isDesktop)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 5, child: queue),
                        const SizedBox(width: 22),
                        Expanded(flex: 6, child: detail),
                      ],
                    )
                  else ...[
                    queue,
                    const SizedBox(height: 18),
                    detail,
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

class _AdminHeader extends StatelessWidget {
  const _AdminHeader({required this.requests});

  final List<HireRequestModel> requests;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: ZokoColors.navy,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Row(
            children: [
              Icon(Icons.admin_panel_settings_rounded, color: ZokoColors.green),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Manage hire requests, quotes, invoices, and job progress.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    height: 1.25,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          childAspectRatio: 1.45,
          children: [
            _AdminStat(
              label: 'New',
              value: '${_countStatus(HireRequestStatus.pendingAdminReview)}',
              icon: Icons.fiber_new_rounded,
            ),
            _AdminStat(
              label: 'Quotes',
              value: '${_countStatus(HireRequestStatus.quoteReceived)}',
              icon: Icons.request_quote_rounded,
            ),
            _AdminStat(
              label: 'Invoices',
              value: '${_countStatus(HireRequestStatus.invoiceSent)}',
              icon: Icons.receipt_long_rounded,
            ),
          ],
        ),
      ],
    );
  }

  int _countStatus(HireRequestStatus status) {
    return requests.where((request) => request.status == status).length;
  }
}

class _AdminStat extends StatelessWidget {
  const _AdminStat({
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
      padding: const EdgeInsets.all(12),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: ZokoColors.teal, size: 20),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              color: ZokoColors.navy,
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              color: ZokoColors.textGrey,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _RequestQueue extends StatelessWidget {
  const _RequestQueue({
    required this.requests,
    required this.selectedRequest,
    required this.onSelected,
  });

  final List<HireRequestModel> requests;
  final HireRequestModel selectedRequest;
  final ValueChanged<HireRequestModel> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Request queue',
            style: TextStyle(
              color: ZokoColors.navy,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 12),
          for (final request in requests) ...[
            _QueueTile(
              request: request,
              isSelected: request == selectedRequest,
              onTap: () => onSelected(request),
            ),
            if (request != requests.last)
              const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class _QueueTile extends StatelessWidget {
  const _QueueTile({
    required this.request,
    required this.isSelected,
    required this.onTap,
  });

  final HireRequestModel request;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final statusColor = hireRequestStatusColor(request.status);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected
              ? ZokoColors.teal.withValues(alpha: 0.09)
              : ZokoColors.canvas,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? ZokoColors.teal : ZokoColors.softGrey,
          ),
        ),
        child: Row(
          children: [
            ClipOval(
              child: Image.asset(
                request.professional.imageAsset,
                width: 46,
                height: 46,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    request.projectTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: ZokoColors.navy,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    request.professional.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: ZokoColors.textGrey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                hireRequestStatusLabel(request.status),
                style: TextStyle(
                  color: statusColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AdminRequestDetail extends StatelessWidget {
  const _AdminRequestDetail({
    required this.request,
    required this.selectedStatus,
    required this.onStatusChanged,
  });

  final HireRequestModel request;
  final HireRequestStatus selectedStatus;
  final ValueChanged<HireRequestStatus> onStatusChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  request.projectTitle,
                  style: const TextStyle(
                    color: ZokoColors.navy,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Icon(Icons.more_horiz_rounded, color: ZokoColors.textGrey),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            request.description,
            style: const TextStyle(color: ZokoColors.textGrey, height: 1.45),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _DetailChip(icon: Icons.person_rounded, label: 'Client: Akosua K.'),
              _DetailChip(
                icon: Icons.workspace_premium_rounded,
                label: request.professional.name,
              ),
              _DetailChip(icon: Icons.payments_rounded, label: request.budget),
              _DetailChip(
                icon: Icons.event_available_rounded,
                label: request.deadline,
              ),
            ],
          ),
          const SizedBox(height: 18),
          _AdminField(label: 'Professional quote', hint: 'e.g. GHS 1,200'),
          const SizedBox(height: 12),
          _AdminField(label: 'Invoice amount', hint: 'e.g. GHS 1,350'),
          const SizedBox(height: 12),
          DropdownButtonFormField<HireRequestStatus>(
            value: selectedStatus,
            decoration: const InputDecoration(
              labelText: 'Request status',
              prefixIcon: Icon(Icons.flag_rounded, color: ZokoColors.teal),
            ),
            items: HireRequestStatus.values
                .where((status) => status != HireRequestStatus.cancelled)
                .map(
                  (status) => DropdownMenuItem(
                    value: status,
                    child: Text(hireRequestStatusLabel(status)),
                  ),
                )
                .toList(),
            onChanged: (status) {
              if (status != null) {
                onStatusChanged(status);
              }
            },
          ),
          const SizedBox(height: 12),
          TextField(
            minLines: 3,
            maxLines: 5,
            decoration: const InputDecoration(
              labelText: 'Admin note',
              hintText: 'Internal update about quote, invoice, or follow-up',
              prefixIcon: Icon(Icons.notes_rounded, color: ZokoColors.teal),
            ),
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.save_rounded),
                label: const Text('Save update'),
              ),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.receipt_long_rounded),
                label: const Text('Send invoice'),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.call_rounded),
                label: const Text('Contact professional'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DetailChip extends StatelessWidget {
  const _DetailChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: ZokoColors.teal.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: ZokoColors.teal, size: 17),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: ZokoColors.navy,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _AdminField extends StatelessWidget {
  const _AdminField({required this.label, required this.hint});

  final String label;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: const Icon(Icons.payments_rounded, color: ZokoColors.teal),
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
