import 'package:zoko_marketplace/models/hire_request_model.dart';
import 'package:zoko_marketplace/models/professional_model.dart';

class HireRequestService {
  const HireRequestService();

  HireRequestModel createRequest({
    required ProfessionalModel professional,
    required String projectTitle,
    required String description,
    required String budget,
    required String deadline,
  }) {
    return HireRequestModel(
      professional: professional,
      projectTitle: projectTitle,
      description: description,
      budget: budget,
      deadline: deadline,
      status: HireRequestStatus.pendingAdminReview,
      createdAt: DateTime.now(),
    );
  }
}
