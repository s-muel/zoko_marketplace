import 'package:flutter/material.dart';

enum ProposalStatus {
  sentToAdmin,
  underReview,
  quoteRequested,
  accepted,
}

class ProfessionalProposalModel {
  const ProfessionalProposalModel({
    required this.jobTitle,
    required this.clientName,
    required this.budget,
    required this.submittedAt,
    required this.message,
    required this.status,
    required this.icon,
    required this.color,
  });

  final String jobTitle;
  final String clientName;
  final String budget;
  final String submittedAt;
  final String message;
  final ProposalStatus status;
  final IconData icon;
  final Color color;
}
