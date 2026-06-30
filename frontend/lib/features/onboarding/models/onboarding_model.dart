import 'package:flutter/material.dart';

class OnboardingModel {
  final IconData mainIcon;
  final List<IconData> floatingIcons;
  final String title;
  final String subtitle;

  const OnboardingModel({
    required this.mainIcon,
    required this.floatingIcons,
    required this.title,
    required this.subtitle,
  });
}

const List<OnboardingModel> onboardingPages = [
  OnboardingModel(
    mainIcon: Icons.dashboard_customize_rounded,
    floatingIcons: [
      Icons.calendar_month_rounded,
      Icons.task_alt_rounded,
      Icons.note_alt_rounded,
      Icons.track_changes_rounded,
    ],
    title: "Organize Everything",
    subtitle:
        "Manage tasks, notes, goals, habits and your schedule from one beautiful workspace.",
  ),

  OnboardingModel(
    mainIcon: Icons.smart_toy_rounded,
    floatingIcons: [
      Icons.psychology_alt_rounded,
      Icons.auto_awesome_rounded,
      Icons.chat_rounded,
      Icons.lightbulb_rounded,
    ],
    title: "AI That Works For You",
    subtitle:
        "Let MindSync plan your day, summarize notes, generate study schedules and keep you productive.",
  ),

  OnboardingModel(
    mainIcon: Icons.emoji_events_rounded,
    floatingIcons: [
      Icons.local_fire_department_rounded,
      Icons.bar_chart_rounded,
      Icons.trending_up_rounded,
      Icons.workspace_premium_rounded,
    ],
    title: "Achieve Your Goals",
    subtitle:
        "Track habits, monitor progress, build consistency and unlock your full potential every day.",
  ),
];
