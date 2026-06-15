import 'package:zoko_marketplace/models/hire_request_model.dart';
import 'package:zoko_marketplace/services/marketplace_service.dart';

class RequestTrackingService {
  const RequestTrackingService();

  static const _marketplaceService = MarketplaceService();

  List<HireRequestModel> getClientRequests() {
    final professionals = _marketplaceService.getTopProfessionals();

    return [
      HireRequestModel(
        professional: professionals[1],
        projectTitle: 'Logo and social media designs',
        description:
            'Need a clean brand identity and launch graphics for a new food business.',
        budget: 'GHS 800',
        deadline: 'June 25, 2026',
        status: HireRequestStatus.pendingAdminReview,
        createdAt: DateTime(2026, 6, 15, 13, 20),
      ),
      HireRequestModel(
        professional: professionals[2],
        projectTitle: 'Marketplace landing page',
        description:
            'Build a responsive landing page for an online services marketplace.',
        budget: 'GHS 2,500',
        deadline: 'July 4, 2026',
        status: HireRequestStatus.quoteReceived,
        createdAt: DateTime(2026, 6, 12, 9, 45),
      ),
      HireRequestModel(
        professional: professionals[0],
        projectTitle: 'Business proposal review',
        description:
            'Review and improve a proposal before sending it to a corporate client.',
        budget: 'GHS 600',
        deadline: 'June 20, 2026',
        status: HireRequestStatus.invoiceSent,
        createdAt: DateTime(2026, 6, 10, 16, 5),
      ),
    ];
  }
}
