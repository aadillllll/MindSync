import 'package:flutter/material.dart';

class QuickActionModel {
  final String title;
  final IconData icon;
  final List<Color> gradient;

  const QuickActionModel({
    required this.title,
    required this.icon,
    required this.gradient,
  });
}
