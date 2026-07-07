import 'package:flutter/material.dart';

import 'quick_action_model.dart';

const quickActions = [
  QuickActionModel(
    title: "Habits",
    icon: Icons.local_fire_department_rounded,
    gradient: [Color(0xff6F49FF), Color(0xff8D63FF)],
  ),

  QuickActionModel(
    title: "Add Note",
    icon: Icons.description_rounded,
    gradient: [Color(0xff2F80ED), Color(0xff57A4FF)],
  ),

  QuickActionModel(
    title: "Goals",
    icon: Icons.track_changes_rounded,
    gradient: [Color(0xff2CB67D), Color(0xff7EE787)],
  ),

  QuickActionModel(
    title: "My Tasks",
    icon: Icons.checklist_rounded,
    gradient: const [Color(0xFF26A69A), Color(0xFF42A5F5)],
  ),
];
