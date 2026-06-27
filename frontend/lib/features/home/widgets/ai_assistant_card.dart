import 'package:flutter/material.dart';

import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/glass_card.dart';

class AIAssistantCard extends StatelessWidget {
  const AIAssistantCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(22),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            colors: [
              const Color(0xff7B5CFF).withValues(alpha: .18),
              const Color(0xff00C2FF).withValues(alpha: .08),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Row(
            children: [
              Container(
                width: 62,
                height: 62,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xff8B5CF6), Color(0xff6D5FFD)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurple.withValues(alpha: .45),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.auto_awesome_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),

              const SizedBox(width: 18),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("MindSync AI", style: AppTextStyles.title),

                    const SizedBox(height: 8),

                    Text(
                      "Need help planning your day?\nAsk your AI assistant.",
                      style: AppTextStyles.bodySecondary,
                    ),

                    const SizedBox(height: 16),

                    SizedBox(
                      height: 42,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff7B5CFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Ask MindSync AI",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
