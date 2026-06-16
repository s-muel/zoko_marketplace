import 'package:flutter/material.dart';

class JobPostModel {
  const JobPostModel({
    required this.title,
    required this.clientName,
    required this.category,
    required this.budget,
    required this.deadline,
    required this.description,
    required this.postedAt,
    required this.icon,
    required this.color,
  });

  final String title;
  final String clientName;
  final String category;
  final String budget;
  final String deadline;
  final String description;
  final String postedAt;
  final IconData icon;
  final Color color;
}
