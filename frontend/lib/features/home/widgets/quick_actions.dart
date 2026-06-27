import 'package:flutter/material.dart';

import '../../../core/theme/app_text_styles.dart';

import '../models/quick_action_dummy_data.dart';
import 'quick_action_card.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quick Actions",
          style: AppTextStyles.title.copyWith(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 18),

        Row(
          children: quickActions
              .map(
                (action) => QuickActionCard(
                  title: action.title,
                  icon: action.icon,
                  gradient: action.gradient,
                  onTap: () {},
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
