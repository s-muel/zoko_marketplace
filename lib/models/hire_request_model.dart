import 'package:zoko_marketplace/models/professional_model.dart';

enum HireRequestStatus {
  pendingAdminReview,
  contactingProfessional,
  quoteReceived,
  invoiceSent,
  paid,
  inProgress,
  completed,
  cancelled,
}

class HireRequestModel {
  const HireRequestModel({
    required this.professional,
    required this.projectTitle,
    required this.description,
    required this.budget,
    required this.deadline,
    required this.status,
    required this.createdAt,
  });

  final ProfessionalModel professional;
  final String projectTitle;
  final String description;
  final String budget;
  final String deadline;
  final HireRequestStatus status;
  final DateTime createdAt;
}
