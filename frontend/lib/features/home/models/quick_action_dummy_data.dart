import 'package:flutter/material.dart';

import 'quick_action_model.dart';

const quickActions = [
  QuickActionModel(
    title: "Add Task",
    icon: Icons.add_task_rounded,
    gradient: [Color(0xff6F49FF), Color(0xff8D63FF)],
  ),

  QuickActionModel(
    title: "Add Note",
    icon: Icons.description_rounded,
    gradient: [Color(0xff2F80ED), Color(0xff57A4FF)],
  ),

  QuickActionModel(
    title: "Add Goal",
    icon: Icons.track_changes_rounded,
    gradient: [Color(0xff2CB67D), Color(0xff7EE787)],
  ),

  QuickActionModel(
    title: "Ask AI",
    icon: Icons.smart_toy_rounded,
    gradient: [Color(0xffF2994A), Color(0xffF6C453)],
  ),
];
