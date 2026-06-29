import 'package:flutter/material.dart';

import 'quick_action_tile.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        QuickActionTile(icon: Icons.smart_toy_rounded, title: "AI Settings"),
        QuickActionTile(
          icon: Icons.calendar_month_rounded,
          title: "Calendar Settings",
        ),
        QuickActionTile(icon: Icons.lock_outline_rounded, title: "Privacy"),
        QuickActionTile(
          icon: Icons.help_outline_rounded,
          title: "Help & Support",
        ),
      ],
    );
  }
}
