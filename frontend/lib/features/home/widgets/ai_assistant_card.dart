import 'package:flutter/material.dart';

import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/theme/app_text_styles.dart';

class AIAssistantCard extends StatelessWidget {
  const AIAssistantCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.smart_toy_rounded, color: Colors.white, size: 28),

              SizedBox(width: 12),

              Text("AI Assistant", style: AppTextStyles.title),
            ],
          ),

          const SizedBox(height: 20),

          Text(
            "Ready to help you organize your day, answer questions, and keep everything on track.",
            style: AppTextStyles.bodySecondary,
          ),

          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            child: PrimaryButton(text: "Start Chat", onPressed: () {}),
          ),
        ],
      ),
    );
  }
}
