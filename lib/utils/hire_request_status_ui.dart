import 'package:flutter/material.dart';
import 'package:zoko_marketplace/core/theme/zoko_colors.dart';
import 'package:zoko_marketplace/models/hire_request_model.dart';

String hireRequestStatusLabel(HireRequestStatus status) {
  return switch (status) {
    HireRequestStatus.pendingAdminReview => 'Pending',
    HireRequestStatus.contactingProfessional => 'Contacting',
    HireRequestStatus.quoteReceived => 'Quote ready',
    HireRequestStatus.invoiceSent => 'Invoice sent',
    HireRequestStatus.paid => 'Paid',
    HireRequestStatus.inProgress => 'In progress',
    HireRequestStatus.completed => 'Completed',
    HireRequestStatus.cancelled => 'Cancelled',
  };
}

Color hireRequestStatusColor(HireRequestStatus status) {
  return switch (status) {
    HireRequestStatus.pendingAdminReview => ZokoColors.teal,
    HireRequestStatus.contactingProfessional => ZokoColors.cyan,
    HireRequestStatus.quoteReceived => ZokoColors.green,
    HireRequestStatus.invoiceSent => const Color(0xFF9A6B00),
    HireRequestStatus.paid => ZokoColors.green,
    HireRequestStatus.inProgress => ZokoColors.navy,
    HireRequestStatus.completed => ZokoColors.green,
    HireRequestStatus.cancelled => const Color(0xFFB42318),
  };
}
