import 'package:flutter/material.dart';

class HabitModel {
  final String title;
  final String subtitle;
  final String percentage;
  final double progress;
  final Color color;
  final IconData icon;

  const HabitModel({
    required this.title,
    required this.subtitle,
    required this.percentage,
    required this.progress,
    required this.color,
    required this.icon,
  });
}
