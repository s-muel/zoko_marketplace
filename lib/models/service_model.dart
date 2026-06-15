import 'package:flutter/material.dart';

class ServiceModel {
  const ServiceModel({
    required this.title,
    required this.price,
    required this.icon,
    required this.color,
  });

  final String title;
  final String price;
  final IconData icon;
  final Color color;
}
