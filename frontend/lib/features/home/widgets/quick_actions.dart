import 'package:flutter/material.dart';

import 'quick_action_card.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Quick Actions",
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 20),

        Row(
          children: [
            QuickActionCard(
              icon: Icons.check_circle_outline,
              title: "Tasks",
              onTap: () {},
            ),

            const SizedBox(width: 16),

            QuickActionCard(
              icon: Icons.calendar_today,
              title: "Calendar",
              onTap: () {},
            ),
          ],
        ),

        const SizedBox(height: 16),

        Row(
          children: [
            QuickActionCard(
              icon: Icons.flag_outlined,
              title: "Goals",
              onTap: () {},
            ),

            const SizedBox(width: 16),

            QuickActionCard(icon: Icons.notes, title: "Notes", onTap: () {}),
          ],
        ),
      ],
    );
  }
}
